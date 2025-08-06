import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:masarat/config/app_route.dart';
import 'package:masarat/core/theme/font_weight_helper.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/widgets/course_card_widget.dart';
import 'package:masarat/core/widgets/custom_drawer.dart';
import 'package:masarat/core/widgets/custom_scaffold.dart';
import 'package:masarat/core/widgets/custom_text.dart';
import 'package:masarat/features/student/cart/data/models/cart_response_model.dart';
import 'package:masarat/features/student/cart/logic/student_cart/student_cart_cubit.dart';
import 'package:masarat/features/student/cart/logic/student_cart/student_cart_state.dart';
import 'package:masarat/features/student/cart/presentation/widgets/cart_item_skeleton.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen>
    with WidgetsBindingObserver {
  late StudentCartCubit _cartCubit;
  final FocusNode _focusNode = FocusNode();
  bool _initialLoading = true;

  @override
  void initState() {
    super.initState();
    _cartCubit = GetIt.instance<StudentCartCubit>();

    // Add listener to focus node to detect when screen gains focus
    _focusNode.addListener(_onFocusChange);

    WidgetsBinding.instance.addObserver(this);

    // Add a post-frame callback to fetch data once the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCartWithRetry();
    });
  }

  // Attempt to load the cart, with retry logic for initial load
  Future<void> _loadCartWithRetry() async {
    try {
      setState(() => _initialLoading = true);
      await _cartCubit.getCart();
    } catch (e) {
      // If there's an error on initial load, we'll let the BLoC error state handle it
      log('Error loading cart: $e');
    } finally {
      if (mounted) setState(() => _initialLoading = false);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Request focus to make sure we get focus events
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // When app is resumed from background
    if (state == AppLifecycleState.resumed) {
      log('App resumed - reloading cart');
      _reloadCart();
    }
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      log('Cart screen gained focus - reloading cart');
      _reloadCart();
    }
  }

  void _reloadCart() {
    log('Reloading cart data');
    if (!_initialLoading) {
      // Only use normal reload if not in initial loading state
      _cartCubit.getCart();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cartCubit,
      child: CustomScaffold(
        haveAppBar: true,
        drawer: const CustomDrawer(),
        backgroundColorAppColor: AppColors.background,
        backgroundColor: AppColors.background,
        drawerIconColor: AppColors.primary,
        body: Focus(
          focusNode: _focusNode,
          child: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Center(
          child: CustomText(
            text: 'سلة المشتريات',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 22.sp,
              fontWeight: FontWeightHelper.regular,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: BlocBuilder<StudentCartCubit, StudentCartState>(
              builder: (context, state) {
                // If we're in initial loading state, use skeleton loading for better UX
                if (_initialLoading) {
                  return _buildSkeletonCartItems();
                }

                return state.when(
                  initial: () => _buildSkeletonCartItems(),
                  loading: () => _buildSkeletonCartItems(),
                  success: (cart) => _buildCartItems(context, cart),
                  error: (message) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: AppColors.red,
                          size: 64.r,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'حدث خطأ أثناء تحميل سلة المشتريات',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeightHelper.medium,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8.h),
                        if (message.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 32.w),
                            child: Text(
                              message,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.gray,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        SizedBox(height: 24.h),
                        ElevatedButton(
                          onPressed: () {
                            context.read<StudentCartCubit>().getCart();
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
                          child: const Text('إعادة المحاولة'),
                        ),
                      ],
                    ),
                  ),
                  checkoutLoading: () => Stack(
                    children: [
                      // Show last known cart state but apply subtle opacity to it
                      Opacity(
                        opacity: 0.6,
                        child: _buildLastKnownCartState(context),
                      ),
                      // Add skeletonized payment processing overlay
                      Container(
                        color:
                            Colors.black.withAlpha(10), // Very subtle overlay
                        child: Center(
                          child: Container(
                            width: 300.w,
                            padding: EdgeInsets.all(24.r),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(40),
                                  blurRadius: 12,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Skeletonizer(
                              enabled: true,
                              effect: const ShimmerEffect(
                                baseColor: AppColors.greyLight200,
                                highlightColor: Colors.white,
                                duration: Duration(milliseconds: 1200),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Payment processing icon
                                  Container(
                                    width: 60.r,
                                    height: 60.r,
                                    decoration: const BoxDecoration(
                                      color: AppColors.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.payments_outlined,
                                      color: Colors.white,
                                      size: 32.r,
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  // Processing text
                                  Container(
                                    height: 24.h,
                                    width: 200.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.greyLight200,
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  // Smaller description text
                                  Container(
                                    height: 16.h,
                                    width: 150.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.greyLight200,
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                  ),
                                  SizedBox(height: 24.h),
                                  // Progress indicator
                                  LinearProgressIndicator(
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                            AppColors.primary),
                                    backgroundColor: AppColors.greyLight200,
                                    minHeight: 6.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  checkoutSuccess: (checkoutData) => Stack(
                    children: [
                      // Show cart state with reduced opacity
                      Opacity(
                        opacity: 0.6,
                        child: _buildLastKnownCartState(context),
                      ),
                      // Success modal with app style
                      Center(
                        child: Container(
                          width: 300.w,
                          padding: EdgeInsets.all(24.r),
                          margin: EdgeInsets.all(16.r),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(40),
                                blurRadius: 12,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 70.r,
                                height: 70.r,
                                decoration: BoxDecoration(
                                  color: Colors.green.shade50,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.green,
                                  size: 40.r,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                'تمت عملية الدفع بنجاح',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeightHelper.semiBold,
                                  color: AppColors.primary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'يمكنك الآن الوصول إلى دوراتك من قائمة دوراتي',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.gray,
                                ),
                              ),
                              SizedBox(height: 24.h),
                              ElevatedButton(
                                onPressed: () {
                                  context.go('/dashboard');
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
                                child: const Text('العودة للرئيسية'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  checkoutError: (message) => Stack(
                    children: [
                      // Show cart state with reduced opacity
                      Opacity(
                        opacity: 0.6,
                        child: _buildLastKnownCartState(context),
                      ),
                      // Error modal with app style
                      Center(
                        child: Container(
                          width: 300.w,
                          padding: EdgeInsets.all(24.r),
                          margin: EdgeInsets.all(16.r),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(40),
                                blurRadius: 12,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 70.r,
                                height: 70.r,
                                decoration: BoxDecoration(
                                  color: Colors.red.shade50,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.error_outline,
                                  color: AppColors.red,
                                  size: 40.r,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                'فشل في إتمام عملية الدفع',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeightHelper.semiBold,
                                  color: AppColors.primary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                message,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.gray,
                                ),
                              ),
                              SizedBox(height: 24.h),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<StudentCartCubit>().getCart();
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
                                child: const Text('حاول مرة أخرى'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        BlocBuilder<StudentCartCubit, StudentCartState>(
          builder: (context, state) {
            // If we're in initial loading state, hide the total section completely
            if (_initialLoading) {
              return _buildSkeletonTotalAndCheckout();
            }

            return state.when(
              initial: () => _buildSkeletonTotalAndCheckout(),
              loading: () => _buildSkeletonTotalAndCheckout(),
              error: (_) => const SizedBox(),
              checkoutLoading: () =>
                  _buildTotalAndCheckoutButton(context, true),
              checkoutSuccess: (_) => const SizedBox(),
              checkoutError: (_) =>
                  _buildTotalAndCheckoutButton(context, false),
              success: (cart) {
                // Debug: Print the current state total amount to verify it's updating
                log('UI rebuilding with cart total: ${cart.totalAmount}');
                log('Cart items count: ${cart.items.length}');

                return _buildTotalAndCheckoutButton(context, false);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildTotalAndCheckoutButton(BuildContext context, bool isLoading) {
    // Try to get cart data
    final cartData = context.read<StudentCartCubit>().state.maybeWhen(
          success: (cart) => cart,
          orElse: () => null,
        );

    // Default values if no cart data
    bool cartIsEmpty = true;
    double displayTotal = 0.0;

    if (cartData != null) {
      // Determine if cart is empty
      cartIsEmpty = cartData.items.isEmpty;
      // Show 0.00 as total if cart is empty, otherwise show the actual total
      displayTotal = cartIsEmpty ? 0.00 : cartData.totalAmount;
    }

    return Padding(
      padding: EdgeInsets.all(16.0.r),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('المجموع الكلي:'),
                Text(
                  'SAR ${displayTotal.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeightHelper.semiBold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          ElevatedButton(
            onPressed: cartIsEmpty || isLoading
                ? null // Disable button when cart is empty or during loading
                : () async {
                    // Initiate checkout process
                    log('Initiating checkout process');
                    final response = await context
                        .read<StudentCartCubit>()
                        .initiateCheckout();

                    if (response != null && context.mounted) {
                      log('Redirecting to payment page: ${response.redirectUrl}');
                      // Push to payment page and listen for when we return
                      context.pushNamed(
                        AppRoute.paymentWebView,
                        extra: {
                          'redirectUrl': response.redirectUrl,
                          'orderId': response.orderId,
                        },
                      ).then((_) {
                        // This runs when we return from the payment page
                        log('Returned from payment page - reloading cart');
                        if (context.mounted) {
                          context.read<StudentCartCubit>().getCart();
                        }
                      });
                    }
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: cartIsEmpty || isLoading
                  ? Colors.grey // Grey out button when disabled
                  : AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 12.h),
            ),
            child: Center(
              child: isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20.h,
                          width: 20.h,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.w,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'جاري التحميل...',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      'ادفع الآن',
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: cartIsEmpty || isLoading
                              ? Colors.grey[300]
                              : Colors.white),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to show the last known cart state when in checkout flow
  // Removed unused method

  Widget _buildSkeletonCartItems() {
    return Skeletonizer(
      enabled: true,
      effect: const ShimmerEffect(
        baseColor: AppColors.greyLight200,
        highlightColor: Colors.white,
        duration: Duration(milliseconds: 1200),
      ),
      containersColor: AppColors.background,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: ListView.builder(
          physics:
              const NeverScrollableScrollPhysics(), // Prevent scrolling during skeleton loading
          itemCount: 3, // Show 3 skeleton items
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: const CartItemSkeleton(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSkeletonTotalAndCheckout() {
    return Skeletonizer(
      enabled: true,
      effect: const ShimmerEffect(
        baseColor: AppColors.greyLight200,
        highlightColor: AppColors.background,
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('المجموع الكلي:'),
                  Text(
                    'SAR 0.00',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeightHelper.semiBold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.h),
              ),
              child: Center(
                child: Text(
                  'ادفع الآن',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLastKnownCartState(BuildContext context) {
    // Try to find the last known cart data
    final cubit = context.read<StudentCartCubit>();
    final lastKnownCart = cubit.state.maybeWhen(
      success: (cartData) => cartData,
      orElse: () => null,
    );

    if (lastKnownCart != null) {
      return _buildCartItems(context, lastKnownCart);
    } else {
      // If we don't have cart data, show skeleton loading
      return _buildSkeletonCartItems();
    }
  }

  Widget _buildCartItems(BuildContext context, CartResponseModel cartData) {
    if (cartData.items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Create a circular container for the icon with primary color background
            Container(
              width: 120.r,
              height: 120.r,
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha((0.1 * 255).toInt()),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 60.r,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 24.h),
            // Title with primary color instead of gray
            Text(
              'سلة المشتريات فارغة',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeightHelper.semiBold,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Text(
                'يمكنك تصفح الدورات التدريبية وإضافتها إلى سلة المشتريات',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.gray,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 32.h),
            // Enhanced button with icon
            ElevatedButton(
              onPressed: () {
                // Navigate to courses screen
                context.pushNamed(AppRoute.trainingCourses);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
                elevation: 2,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.search, size: 18.r),
                  SizedBox(width: 8.w),
                  const Text('تصفح الدورات'),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: cartData.items.length,
      itemBuilder: (context, index) {
        final item = cartData.items[index];
        // Use dynamic data from the item model and include the image
        return CourseCard(
          title: item.course.title,
          price: 'السعر : SAR ${item.price.toStringAsFixed(2)}',
          havePrice: true,
          // Pass the image URL
          image: item.course.coverImageUrl,
          // Use empty strings for hours and lectures as we want to remove them
          hours: '',
          lectures: '',
          actions: [
            ElevatedButton(
              onPressed: () {
                // Show loading indicator
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('جاري حذف العنصر من السلة...'),
                    duration: Duration(seconds: 1),
                  ),
                );

                // Remove from Cart Logic
                final scaffoldMessenger = ScaffoldMessenger.of(context);
                context
                    .read<StudentCartCubit>()
                    .removeFromCart(item.course.id)
                    .then((success) {
                  if (success) {
                    scaffoldMessenger.showSnackBar(
                      const SnackBar(
                        content: Text('تم حذف العنصر من السلة بنجاح'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    scaffoldMessenger.showSnackBar(
                      const SnackBar(
                        content: Text('فشل في حذف العنصر من السلة'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.background,
                side: const BorderSide(color: AppColors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 8.h,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.delete_outline,
                    color: AppColors.red,
                    size: 18.r,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'حذف من السلة',
                    style: TextStyle(
                      color: AppColors.red,
                      fontSize: 12.sp,
                      fontWeight: FontWeightHelper.medium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
