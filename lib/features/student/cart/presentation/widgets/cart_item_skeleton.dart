import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/widgets/course_card_widget.dart';

/// A skeleton widget for cart items used during loading
class CartItemSkeleton extends StatelessWidget {
  const CartItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return CourseCard(
      title: 'Loading Course Title...',
      price: 'السعر : SAR 0.00',
      havePrice: true,
      image: '',
      hours: '',
      lectures: '',
      actions: [
        ElevatedButton(
          onPressed: null, // Disabled button during skeleton state
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.background,
            side: const BorderSide(color: Colors.grey),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
          child: Text(
            'حذف من السلة',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
    );
  }
}
