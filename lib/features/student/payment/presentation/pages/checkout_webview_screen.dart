import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:masarat/core/theme/font_weight_helper.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/widgets/custom_scaffold.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// A screen that displays a WebView for the payment checkout process with improved UI
class CheckoutWebViewScreen extends StatefulWidget {
  /// The URL to load in the WebView
  final String redirectUrl;

  /// The order ID associated with this checkout
  final String orderId;

  /// Constructor
  const CheckoutWebViewScreen({
    Key? key,
    required this.redirectUrl,
    required this.orderId,
  }) : super(key: key);

  @override
  State<CheckoutWebViewScreen> createState() => _CheckoutWebViewScreenState();
}

class _CheckoutWebViewScreenState extends State<CheckoutWebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  void _initWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100) {
              setState(() {
                _isLoading = false;
              });
            }
          },
          onPageStarted: (String url) {
            log('Page started loading: $url');
          },
          onPageFinished: (String url) {
            log('Page finished loading: $url');

            // Check for successful payment or cancellation
            if (url.contains('success') || url.contains('completed')) {
              // Payment successful
              _handlePaymentSuccess();
            } else if (url.contains('cancel') || url.contains('failed')) {
              // Payment cancelled or failed
              _handlePaymentFailure();
            }
          },
          onWebResourceError: (WebResourceError error) {
            log('Web resource error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.redirectUrl));
  }

  void _handlePaymentSuccess() {
    // Show success dialog with app style
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: const Text(
          'نجاح الدفع',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeightHelper.semiBold,
          ),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              color: AppColors.primary,
              size: 64.r,
            ),
            SizedBox(height: 16.h),
            const Text('تمت عملية الدفع بنجاح!'),
            SizedBox(height: 8.h),
            Text(
              'رقم الطلب: ${widget.orderId}',
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.gray,
              ),
            ),
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigate back to cart with success result
                context.pop(true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 32.w,
                  vertical: 12.h,
                ),
              ),
              child: const Text('موافق'),
            ),
          ),
        ],
      ),
    );
  }

  void _handlePaymentFailure() {
    // Show failure dialog with app style
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: const Text(
          'فشل الدفع',
          style: TextStyle(
            color: AppColors.red,
            fontWeight: FontWeightHelper.semiBold,
          ),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              color: AppColors.red,
              size: 64.r,
            ),
            SizedBox(height: 16.h),
            const Text('لم تتم عملية الدفع. يرجى المحاولة مرة أخرى.'),
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigate back to cart with failure result
                context.pop(false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 32.w,
                  vertical: 12.h,
                ),
              ),
              child: const Text('موافق'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      haveAppBar: true,
      title: 'الدفع',
      drawerIconColor: AppColors.primary,
      backgroundColor: AppColors.background,
      backgroundColorAppColor: AppColors.background,
      showBackButton: true,
      onBackPressed: () => context.pop(false),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading) _buildLoadingOverlay(),
        ],
      ),
    );
  }

  Widget _buildLoadingOverlay() {
    return Container(
      color: AppColors.background,
      child: Skeletonizer(
        enabled: true,
        effect: const ShimmerEffect(
          baseColor: AppColors.greyLight200,
          highlightColor: AppColors.background,
        ),
        child: Column(
          children: [
            SizedBox(height: 24.h),
            // Payment header
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              height: 60.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            SizedBox(height: 16.h),
            // Payment form
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              height: 200.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 24.h,
                    width: 200.w,
                    color: Colors.white,
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    height: 48.h,
                    color: Colors.white,
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    height: 48.h,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            // Payment options
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              height: 100.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            SizedBox(height: 16.h),
            // Payment button
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              height: 48.h,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
