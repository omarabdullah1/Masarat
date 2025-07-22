import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:masarat/core/theme/font_weight_helper.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/widgets/course_card_widget.dart';
import 'package:masarat/core/widgets/custom_drawer.dart';
import 'package:masarat/core/widgets/custom_scaffold.dart';
import 'package:masarat/core/widgets/custom_text.dart';
import 'package:masarat/features/student/cart/data/models/cart_response_model.dart';
import 'package:masarat/features/student/cart/logic/student_cart/student_cart_cubit.dart';
import 'package:masarat/features/student/cart/logic/student_cart/student_cart_state.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<StudentCartCubit>()..getCart(),
      child: CustomScaffold(
        haveAppBar: true,
        drawer: const CustomDrawer(),
        backgroundColorAppColor: AppColors.background,
        backgroundColor: AppColors.background,
        drawerIconColor: AppColors.primary,
        body: _buildBody(context),
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
                return state.maybeWhen(
                  initial: () => const Center(child: Text('Loading cart...')),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  success: (cart) => _buildCartItems(context, cart),
                  error: (message) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Error: $message'),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<StudentCartCubit>().getCart();
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                  orElse: () => const Center(child: Text('Unknown state')),
                );
              },
            ),
          ),
        ),
        BlocBuilder<StudentCartCubit, StudentCartState>(
          builder: (context, state) {
            return state.maybeWhen(
              success: (cart) {
                // Debug: Print the current state total amount to verify it's updating
                log('UI rebuilding with cart total: ${cart.totalAmount}');
                log('Cart items count: ${cart.items.length}');

                // Determine if cart is empty
                final bool cartIsEmpty = cart.items.isEmpty;

                // Show 0.00 as total if cart is empty, otherwise show the actual total
                final double displayTotal =
                    cartIsEmpty ? 0.00 : cart.totalAmount;

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
                        onPressed: cartIsEmpty
                            ? null // Disable button when cart is empty
                            : () {
                                // Logic for payment
                                log('Proceed to Payment');
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: cartIsEmpty
                              ? Colors.grey // Grey out button when disabled
                              : AppColors.primary,
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
                                color: cartIsEmpty
                                    ? Colors.grey[300]
                                    : Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              orElse: () => const SizedBox(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCartItems(BuildContext context, CartResponseModel cartData) {
    if (cartData.items.isEmpty) {
      return const Center(child: Text('سلة المشتريات فارغة'));
    }

    return ListView.builder(
      itemCount: cartData.items.length,
      itemBuilder: (context, index) {
        final item = cartData.items[index];
        return CourseCard(
          title: item.course.title,
          price: 'السعر : SAR ${item.price.toStringAsFixed(2)}',
          havePrice: true,
          hours: '7 ساعات', // This should come from the API if available
          lectures:
              'عدد المحاضرات: -', // This should come from the API if available
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
                context
                    .read<StudentCartCubit>()
                    .removeFromCart(item.course.id)
                    .then((success) {
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('تم حذف العنصر من السلة بنجاح'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
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
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              child: const Text(
                'حذف من السلة',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
