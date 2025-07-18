import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
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
    log(image ?? 'No image provided', name: 'CourseCard');
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3, // Give more space to the content column
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
                          color: AppColors.greyLight200,
                          fontWeight: FontWeightHelper.light,
                          fontSize: 10.sp,
                        ),
                      ),
                      CustomText(
                        text: lectures,
                        style: TextStyle(
                          color: AppColors.greyLight200,
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
                                color: AppColors.greyLight200,
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
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: actions.map((action) {
                            // If the action is an Expanded widget, replace it with the child
                            if (action is Expanded) {
                              return action.child;
                            }
                            return action;
                          }).toList(),
                        ),
                      ),
                      Gap(4.h),
                    ],
                  ),
                ),
                Gap(8.w), // Reduced gap
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: image != null
                      ? CachedNetworkImage(
                          imageUrl: image!,
                          height: 100.h,
                          width: 90.w,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: AppColors.lighterGray,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: AppColors.lighterGray,
                            child: const Icon(Icons.broken_image_outlined,
                                color: AppColors.gray),
                          ),
                        )
                      : Container(
                          height: 130.h,
                          width: 90.w,
                          color: AppColors.lighterGray,
                          // child: const Center(
                          //   child: Icon(
                          //     Icons.image_not_supported,
                          //     color: AppColors.gray,
                          //   ),
                          // ),
                        ),
                ),
              ],
            ),
            if (onSecondaryAction != null && secondaryActionText != null) ...[
              Gap(8.h),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                width: double.infinity,
                child: CustomButton(
                  height: 30.h,
                  radius: 58.r,
                  labelText: secondaryActionText!,
                  buttonColor: AppColors.background,
                  textColor: AppColors.primary,
                  onTap: onSecondaryAction,
                  textFontSize: 9.sp,
                  fontWeight: FontWeightHelper.light,
                  borderColor: AppColors.primary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
