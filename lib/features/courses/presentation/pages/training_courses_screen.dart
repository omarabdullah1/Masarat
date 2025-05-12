import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:masarat/config/app_route.dart';
import 'package:masarat/core/theme/font_weight_helper.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/widgets/app_text_form_field.dart';
import 'package:masarat/core/widgets/course_card_widget.dart';
import 'package:masarat/core/widgets/custom_button.dart';
import 'package:masarat/core/widgets/custom_drawer.dart';
import 'package:masarat/core/widgets/custom_dropdown_button_form_field.dart';
import 'package:masarat/core/widgets/custom_scaffold.dart';
import 'package:masarat/core/widgets/custom_text.dart';

class TrainingCoursesScreen extends StatefulWidget {
  const TrainingCoursesScreen({super.key});

  @override
  State<TrainingCoursesScreen> createState() => _MyLibraryState();
}

class _MyLibraryState extends State<TrainingCoursesScreen> {
  String? selectedOption; // Moved outside build to retain state

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      haveAppBar: true,
      backgroundColorAppColor: AppColors.background,
      backgroundColor: AppColors.background,
      drawerIconColor: AppColors.primary,
      drawer: const CustomDrawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Center(
              child: CustomText(
                text: 'الــدورات التدريبيــة',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 22.sp,
                  fontWeight: FontWeightHelper.regular,
                ),
              ),
            ),
            Gap(16.h),
            Row(
              children: [
                // Search Field
                Expanded(
                  flex: 4,
                  child: AppTextFormField(
                    hintText: 'بحث عن الدورات التدريبية ...',
                    backgroundColor: AppColors.withe,
                    validator: (value) {
                      return null; // Replace with your validation logic
                    },
                  ),
                ),
                SizedBox(width: 16.w), // Space between search and dropdown
                // Dropdown
                Expanded(
                  flex: 2,
                  child: CustomDropdownButton(
                    items: const ['Item 1', 'Item 2', 'Item 3'],
                    hintText: 'فلترة حسب القسم',
                    onChanged: (value) {
                      log('Selected Value: $value');
                    },
                  ),
                ),
              ],
            ),
            Gap(24.h), // Space after row
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      context.goNamed(
                        AppRoute.courseDetails,
                        pathParameters: {'courseId': '123'},
                      );
                    },
                    child: CourseCard(
                      title: 'مهارات أخصائي محاسبة',
                      hours: 'عدد الساعات : 7 ساعات',
                      lectures: 'عدد المحاضرات: 42',
                      actions: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: CustomButton(
                                  height: 27.h,
                                  radius: 58.r,
                                  labelText: 'شــراء الأن',
                                  buttonColor: AppColors.primary,
                                  textColor: AppColors.withe,
                                  onTap: () {},
                                  textFontSize: 8.sp,
                                  fontWeight: FontWeightHelper.light,
                                ),
                              ),
                              Gap(14.w),
                              Expanded(
                                child: CustomButton(
                                  height: 27.h,
                                  labelText: 'إضافة إلى السلة',
                                  radius: 58.r,
                                  buttonColor: AppColors.background,
                                  textColor: AppColors.yellow,
                                  onTap: () {},
                                  textFontSize: 8.sp,
                                  borderColor: AppColors.yellow,
                                  fontWeight: FontWeightHelper.light,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      onSecondaryAction: () {},
                      secondaryActionText: 'مشاهدة أول محاضرة مجاناً',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
