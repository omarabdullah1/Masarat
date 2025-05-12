import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:masarat/core/theme/font_weight_helper.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/widgets/custom_button.dart';
import 'package:masarat/core/widgets/custom_text.dart';

class CourseCard extends StatelessWidget {
  // Optional text for the secondary action

  const CourseCard({
    required this.title,
    required this.hours,
    required this.lectures,
    required this.actions,
    super.key,
    this.progress,
    this.price,
    this.image,
    this.onSecondaryAction,
    this.secondaryActionText,
    this.havePrice = false,
  });
  final String title;
  final String hours;
  final String? image;
  final String lectures;
  final double? progress;
  final String? price;
  final bool havePrice;
  final List<Widget> actions;
  final VoidCallback? onSecondaryAction;
  // Optional secondary action (e.g., "Watch First Lecture")
  final String? secondaryActionText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0.r),
        border: Border.all(
          color: AppColors.lighterGray,
          width: 2.0.w,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(6.0.r),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                      ),
                      Gap(5.h),
                      if (havePrice) ...[
                        CustomText(
                          text: price!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                      Gap(8.h),
                      CustomText(
                        text: hours,
                        style: TextStyle(
                          color: AppColors.gery200,
                          fontWeight: FontWeightHelper.light,
                          fontSize: 10.sp,
                        ),
                      ),
                      CustomText(
                        text: lectures,
                        style: TextStyle(
                          color: AppColors.gery200,
                          fontWeight: FontWeightHelper.light,
                          fontSize: 10.sp,
                        ),
                      ),
                      if (progress != null) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: 'مستوي الاكتمال',
                              style: TextStyle(
                                color: AppColors.gery200,
                                fontWeight: FontWeightHelper.light,
                                fontSize: 10.sp,
                              ),
                            ),
                            Text(
                              '${(progress! * 100).toInt()}%',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.teal,
                              ),
                            ),
                          ],
                        ),
                      ],
                      Gap(8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: actions, // Render dynamic actions.
                      ),
                      Gap(4.h),
                    ],
                  ),
                ),
                Gap(16.w),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://www.gstatic.com/earth/social/00_generic_facebook-001.jpg',
                    // Replace with your image URL
                    height: 130.h,
                    width: 104.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            if (onSecondaryAction != null && secondaryActionText != null) ...[
              Gap(8.h),
              CustomButton(
                height: 27.h,
                radius: 58.r,
                labelText: secondaryActionText!,
                buttonColor: AppColors.background,
                textColor: AppColors.gray,
                onTap: onSecondaryAction,
                textFontSize: 10.sp,
                fontWeight: FontWeightHelper.light,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
