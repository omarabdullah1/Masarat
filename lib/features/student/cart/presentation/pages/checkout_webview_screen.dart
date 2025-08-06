import 'dart:async';
import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Add this import if you have connectivity package, otherwise comment it out
// import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../../../core/theme/font_weight_helper.dart';
import '../../../../../core/utils/app_colors.dart';

class CheckoutWebViewScreen extends StatefulWidget {
  final String redirectUrl;
  final String orderId;

  const CheckoutWebViewScreen({
    Key? key,
    required this.redirectUrl,
    required this.orderId,
  }) : super(key: key);

  @override
  State<CheckoutWebViewScreen> createState() => _CheckoutWebViewScreenState();
}

class _CheckoutWebViewScreenState extends State<CheckoutWebViewScreen> {
  late final WebViewController controller;
  bool isLoading = true;
  int _loadingTimeSeconds = 0;
  Timer? _loadingTimer;
  bool _isRecoveryInProgress = false;
  DateTime _lastRecoveryAttempt =
      DateTime.now().subtract(const Duration(minutes: 5));

  void _startLoadingTimer() {
    // Start a timer to track loading time and handle timeouts
    _loadingTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        _loadingTimeSeconds += 5;
      });

      // Add page recovery check after 20 seconds
      if (_loadingTimeSeconds >= 20 && isLoading && !_isRecoveryInProgress) {
        // Make sure we don't attempt recovery more than once per minute
        final now = DateTime.now();
        if (now.difference(_lastRecoveryAttempt).inSeconds >= 60) {
          _isRecoveryInProgress = true;
          _lastRecoveryAttempt = now;
          _attemptRecovery();
        }
      }
    });
  }

  @override
  void dispose() {
    _loadingTimer?.cancel();
    super.dispose();
  }

  // Add a method to directly detect the error dialog in the webview
  Future<void> _detectTapPaymentError() async {
    try {
      // Inject JavaScript to look for the specific error message in the DOM
      final String result = await controller.runJavaScriptReturningResult('''
        (function() {
          // Check for specific error URL patterns
          var currentUrl = window.location.href;
          if(currentUrl.includes("error.html?aspxerrorpath=") || 
             currentUrl.includes("aspxerrorpath=/gosell/v2/payment/undefined") ||
             currentUrl.includes("/gosell/v2/error.html") ||
             currentUrl.includes("/gosell/v2/payment/undefined/my-learning")) {
            return "SPECIFIC_ERROR_URL_DETECTED";
          }
          
          // Check for error dialog with specific error code
          var errorText = document.body.innerText || "";
          if(errorText.includes("50001") || errorText.includes("Card loading timeout")) {
            return "ERROR_DETECTED";
          }
          
          // Check for specific elements that appear in the error page
          var errorElement = document.querySelector('.error-container') || 
                            document.querySelector('.payment-error') ||
                            document.querySelector('.alert-error');
          if(errorElement) {
            return "ERROR_ELEMENT_FOUND";
          }
          
          // Look for the Go Back button which typically appears in error scenarios
          var backButton = Array.from(document.querySelectorAll('button')).find(btn => 
            btn.innerText.includes('Go Back') || btn.innerText.includes('Back') || btn.innerText.includes('رجوع')
          );
          if(backButton) {
            return "BACK_BUTTON_FOUND";
          }
          
          return "NO_ERROR_DETECTED";
        })();
      ''') as String;

      log('Error detection result: $result');

      if (result.contains("SPECIFIC_ERROR_URL_DETECTED")) {
        // Specific error URL detected, go back to cart immediately
        if (mounted) {
          log('Specific payment error URL detected from JS');
          _loadingTimer?.cancel();
          _showPaymentResult(false);
        }
      } else if (result.contains("ERROR") ||
          result.contains("BACK_BUTTON_FOUND")) {
        // Error detected, handle without showing dialog
        if (mounted) {
          log('Payment error detected from JS: 50001 Card loading timeout');
          _handleTimeoutErrorRecovery();
          setState(() {
            isLoading = false;
          });
        }
      }
    } catch (e) {
      log('Error running JavaScript: $e');
    }
  }

  // This method has been removed as it's no longer needed

  @override
  void initState() {
    super.initState();

    // Add an initial delay before starting the timer to give more time for initial loading
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted) {
        _startLoadingTimer();
      }
    });

    // Use a longer initial check timeout - delay first error check to give more time
    Future.delayed(const Duration(seconds: 30), () {
      if (mounted && isLoading) {
        _detectTapPaymentError();
      }
    });

    // Also add a specific error check after a short delay to catch quick failures
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted && isLoading) {
        controller.currentUrl().then((url) {
          if (url != null &&
              (url.contains('/gosell/v2/error.html') ||
                  url.contains('/gosell/v2/payment/undefined/my-learning') ||
                  url.contains('error.html?aspxerrorpath=') ||
                  url.contains('aspxerrorpath=/gosell/v2/payment/undefined'))) {
            log('Early detection of specific error URL: $url');
            _loadingTimer?.cancel();
            _showPaymentResult(false);
          }
        }).catchError((e) {
          log('Error in early URL check: $e');
        });
      }
    });

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // Enable DOM storage to improve loading performance
      ..setBackgroundColor(Colors.white)
      ..enableZoom(false) // Disable zoom to improve performance
      // Add JavaScript channel for communication from webview to Flutter
      ..addJavaScriptChannel(
        'PaymentErrorChannel',
        onMessageReceived: (message) {
          final errorMsg = message.message;
          log('JavaScript message: $errorMsg');

          if (errorMsg.contains('50001') ||
              errorMsg.contains('Card loading timeout') ||
              errorMsg.contains('CONNECTION_TIMEOUT')) {
            // Handle silently without showing dialog
            _handleTimeoutErrorRecovery();
          } else {
            // For other errors, just try to reload or go back
            if (mounted) {
              controller.reload();
            }
          }
        },
      )
      // Add an additional channel for more specific error detection with debounce
      ..addJavaScriptChannel(
        'TapErrorDetector',
        onMessageReceived: (JavaScriptMessage message) {
          log('TapErrorDetector received: ${message.message}');
          // Handle error silently without showing dialog with debounce protection
          if (message.message.contains('50001')) {
            // Check if we've attempted recovery too recently
            final now = DateTime.now();
            if (!_isRecoveryInProgress &&
                now.difference(_lastRecoveryAttempt).inSeconds >= 60) {
              _handleTimeoutErrorRecovery();
            } else {
              log('Skipping recovery attempt - already in progress or attempted too recently');
            }
          }
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            log('Page started loading: $url');
            // Reset timeout if page actually started loading
            _loadingTimeSeconds = 0;
            setState(() {
              isLoading = true;
            });

            // Give the page more time to start loading before injecting scripts
            // Delay JS injection to give page more time to load
            Future.delayed(const Duration(seconds: 15), () {
              if (mounted) {
                controller.runJavaScript('''
                  // Error detection with debounce mechanism
                  var lastErrorReported = Date.now() - 120000; // Start with a value 2 minutes ago
                  
                  function shouldReportError() {
                    var now = Date.now();
                    var timeSinceLastReport = now - lastErrorReported;
                    // Only report errors if it's been at least 60 seconds since last report
                    if (timeSinceLastReport >= 60000) {
                      lastErrorReported = now;
                      return true;
                    }
                    return false;
                  }
                  
                  // Check if current URL matches the error pattern
                  if (window.location.href.includes('error.html?aspxerrorpath=') || 
                      window.location.href.includes('aspxerrorpath=/gosell/v2/payment/undefined') ||
                      window.location.href.includes('/gosell/v2/error.html') ||
                      window.location.href.includes('/gosell/v2/payment/undefined/my-learning')) {
                    TapErrorDetector.postMessage('Detected specific error page URL');
                  }
                  
                  // Override the Tap payment gateway's error handling to detect card loading timeout
                  window.addEventListener('error', function(e) {
                    if (e.message && (e.message.includes('50001') || e.message.includes('Card loading timeout'))) {
                      if (shouldReportError()) {
                        TapErrorDetector.postMessage('50001: Card loading timeout');
                      } else {
                        console.log('Suppressing duplicate error report');
                      }
                    }
                    console.error('Captured error: ' + e.message);
                  });
                  
                  // Monitor for network errors with reduced sensitivity
                  window.addEventListener('unhandledrejection', function(e) {
                    if (e.reason && e.reason.toString().includes('network')) {
                      if (shouldReportError()) {
                        TapErrorDetector.postMessage('Network connection error');
                      } else {
                        console.log('Suppressing duplicate network error report');
                      }
                    }
                    console.error('Unhandled rejection: ' + e.reason);
                  });
                  
                  // Create a MutationObserver with debouncing to detect when error messages appear in the DOM
                  var observer = new MutationObserver(function(mutations) {
                    // Skip DOM checks if we recently reported an error
                    if (!shouldReportError()) {
                      return;
                    }
                    
                    for(var mutation of mutations) {
                      if(mutation.addedNodes.length) {
                        for(var node of mutation.addedNodes) {
                          if(node.nodeType === 1 && (node.tagName === 'DIV' || node.tagName === 'SPAN')) {
                            var text = node.innerText || '';
                            if(text.includes('50001') || text.includes('Card loading timeout')) {
                              // Set the time but don't call shouldReportError again
                              lastErrorReported = Date.now();
                              TapErrorDetector.postMessage('50001: Card loading timeout');
                              break;
                            }
                          }
                        }
                      }
                    }
                  });
                  
                  // Start observing the document body for DOM changes
                  setTimeout(function() {
                    if(document.body) {
                      observer.observe(document.body, { childList: true, subtree: true });
                    }
                  }, 2000); // Increased delay before starting observation
                ''').catchError((error) {
                  log('Error injecting error detection script: $error');
                });
              }
            });
          },
          onPageFinished: (String url) {
            log('Page finished loading: $url');

            // Check for visible error page immediately
            _detectTapPaymentError();

            // Check for specific error paths that should redirect to cart immediately
            if (url.contains('aspxerrorpath=/gosell/v2/payment/undefined') ||
                url.contains('error.html?aspxerrorpath=') ||
                url.contains('/gosell/v2/error.html') ||
                url.contains('/gosell/v2/payment/undefined/my-learning')) {
              log('Specific payment error page detected: $url');
              _loadingTimer?.cancel(); // Cancel any timers
              _showPaymentResult(
                  false); // Show failure message and return to cart
              return;
            }

            // Also use the URL detection for general error patterns
            if (url.contains('50001') ||
                url.contains('timeout') ||
                url.contains('error') ||
                url.contains('fail')) {
              log('Payment error detected from URL: $url');
              // Handle silently without showing dialog
              _handleTimeoutErrorRecovery();
              return;
            }

            // Add a more aggressive error check that runs after a short delay
            Future.delayed(const Duration(milliseconds: 800), () {
              if (mounted) {
                _detectTapPaymentError();
              }
            });

            setState(() {
              isLoading = false;
            });

            // Check for success or failure in the URL
            if (url.contains('success') || url.contains('status=CAPTURED')) {
              log('Payment successful');
              // Cancel the loading timer
              _loadingTimer?.cancel();
              // Show success message and navigate back
              _showPaymentResult(true);
            } else if (url.contains('fail') || url.contains('status=FAILED')) {
              log('Payment failed');
              // Cancel the loading timer
              _loadingTimer?.cancel();
              // Show failure message
              _showPaymentResult(false);
            }
          },
          onWebResourceError: (WebResourceError error) {
            log('Error loading page: ${error.description}');
            setState(() {
              isLoading = false;
            });

            // Handle web resource error silently with debounce protection
            if (mounted) {
              // Only try recovery if we haven't attempted too recently
              final now = DateTime.now();
              if (!_isRecoveryInProgress &&
                  now.difference(_lastRecoveryAttempt).inSeconds >= 60) {
                // For resource errors, try recovery or go back to cart
                _handleTimeoutErrorRecovery();
              } else {
                log('Skipping error recovery - already in progress or attempted too recently');
              }
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            // Check for payment gateway errors in the URL
            final url = request.url;
            log('Navigation request to: $url');

            // Check for specific error codes or error paths in the URL
            if (url.contains('50001') ||
                url.contains('Card loading timeout') ||
                url.contains('aspxerrorpath=/gosell/v2/payment/undefined') ||
                url.contains('error.html?aspxerrorpath=') ||
                url.contains('/gosell/v2/error.html') ||
                url.contains('/gosell/v2/payment/undefined/my-learning')) {
              log('Payment error detected in navigation request URL');
              // Handle silently without showing dialog
              _showPaymentResult(false); // Show failure message
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.redirectUrl));
  }

  void _showPaymentResult(bool success) {
    final message = success
        ? 'تمت عملية الدفع بنجاح'
        : 'فشلت عملية الدفع، يرجى المحاولة مرة أخرى';

    showToast(
      message,
      context: context,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.center,
      duration: const Duration(seconds: 3),
    );

    Future.delayed(const Duration(seconds: 2), () {
      // Navigate back to the home or cart screen
      if (mounted) {
        context.pop();
      }
    });
  }

  // This method has been merged into _handleTimeoutErrorRecovery()

  // This method attempts to recover from loading issues
  Future<void> _attemptRecovery() async {
    log('Attempting recovery after $_loadingTimeSeconds seconds of loading');
    try {
      // Just reload the page as a recovery strategy
      await controller.reload();
      setState(() {
        _isRecoveryInProgress = false;
      });
    } catch (e) {
      log('Error during recovery attempt: $e');
      _isRecoveryInProgress = false;
    }
  }

  // Handle all payment error recovery strategies silently with debouncing
  void _handleTimeoutErrorRecovery() {
    // First try a direct bypass approach
    log('Attempting automatic recovery for payment error');

    // Check if recovery is already in progress or if we attempted recovery too recently
    final now = DateTime.now();
    if (_isRecoveryInProgress ||
        now.difference(_lastRecoveryAttempt).inSeconds < 60) {
      log('Skipping recovery attempt - already in progress or attempted too recently');
      return;
    }

    _isRecoveryInProgress = true;
    _lastRecoveryAttempt = now;

    // Don't show any dialog, just try recovery strategies

    // Clear WebView cache and local storage
    controller.clearCache();
    controller.clearLocalStorage();

    // Reset the loading timer
    setState(() {
      _loadingTimeSeconds = 0;
      isLoading = true;
    });

    // Try multiple recovery strategies silently
    try {
      // Strategy 1: Try loading with a bypass parameter
      controller
          .loadRequest(Uri.parse('${widget.redirectUrl}&bypass_timeout=true'));

      // Show a very minimal toast to indicate something is happening
      showToast(
        'جاري إعادة المحاولة...',
        context: context,
        animation: StyledToastAnimation.fade,
        reverseAnimation: StyledToastAnimation.fade,
        position: StyledToastPosition.bottom,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.black54,
      );

      // If still loading after 30 seconds, try one more approach
      Future.delayed(const Duration(seconds: 30), () {
        if (mounted && isLoading) {
          // Strategy 2: Try a direct reload
          controller.reload();

          // Reset the recovery flag after attempting
          _isRecoveryInProgress = false;

          // Give it 5 more seconds before giving up
          Future.delayed(const Duration(seconds: 5), () {
            if (mounted && isLoading) {
              // Final strategy: Just go back to cart
              context.pop();
            }
          });
        } else {
          // Reset the recovery flag
          _isRecoveryInProgress = false;
        }
      });
    } catch (e) {
      log('Error in silent recovery attempt: $e');
      // Reset the recovery flag
      _isRecoveryInProgress = false;
      // Just go back to cart if recovery fails
      if (mounted) {
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // Prevent accidental back navigation during payment processing
      onWillPop: () async {
        // Show confirmation dialog if in the middle of payment process
        if (isLoading && _loadingTimeSeconds < 5) {
          return await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('هل أنت متأكد؟'),
                  content: const Text(
                      'العملية قيد التنفيذ. هل تريد بالتأكيد إلغاء عملية الدفع؟'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('لا'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('نعم'),
                    ),
                  ],
                ),
              ) ??
              false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('إتمام الدفع'),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: Stack(
          children: [
            WebViewWidget(controller: controller),
            if (isLoading) _buildSkeletonTotalAndCheckout(),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonTotalAndCheckout() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Payment processing icon in a circular container
            Container(
              width: 80.r,
              height: 80.r,
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha((0.1 * 255).toInt()),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Skeletonizer(
                  enabled: true,
                  effect: const ShimmerEffect(
                    baseColor: AppColors.greyLight200,
                    highlightColor: Colors.white,
                    duration: Duration(milliseconds: 1200),
                  ),
                  child: Icon(
                    Icons.credit_card,
                    color: AppColors.primary,
                    size: 40.r,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Loading text
            Text(
              'جاري تحميل بوابة الدفع',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeightHelper.semiBold,
                color: AppColors.primary,
              ),
            ),

            SizedBox(height: 8.h),

            // Subtext with helpful information
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Text(
                'يرجى الانتظار قليلاً. قد يستغرق تحميل بوابة الدفع بعض الوقت.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.gray,
                ),
              ),
            ),

            SizedBox(height: 32.h),

            // Loading indicator
            SizedBox(
              width: 200.w,
              child: Column(
                children: [
                  LinearProgressIndicator(
                    backgroundColor: AppColors.greyLight200,
                    // Cap the visual progress at 60s for UI purposes, though actual timeout is 90s
                    value: _loadingTimeSeconds / 60.0 > 1.0
                        ? 1.0
                        : _loadingTimeSeconds / 60.0,
                    valueColor: AlwaysStoppedAnimation<Color>(_loadingTimeSeconds >
                            50
                        ? AppColors
                            .red // Turn red when getting close to visual timeout
                        : AppColors.primary),
                    minHeight: 6.h,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '${_loadingTimeSeconds}s / 60s',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.gray,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40.h),

            // Timeout notice with remaining seconds (updated to 60s timeout)
            Text(
              'إذا استمر التحميل لفترة طويلة، اضغط على زر الرجوع (${_loadingTimeSeconds < 60 ? 60 - _loadingTimeSeconds : 0} ثانية)',
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.gray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
