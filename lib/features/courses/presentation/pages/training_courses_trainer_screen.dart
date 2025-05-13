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
import 'package:masarat/core/widgets/custom_scaffold.dart';
import 'package:masarat/core/widgets/custom_text.dart';

class TrainingCoursesTrainerScreen extends StatefulWidget {
  const TrainingCoursesTrainerScreen({super.key});

  @override
  State<TrainingCoursesTrainerScreen> createState() =>
      _TrainingCoursesTrainerScreenState();
}

class _TrainingCoursesTrainerScreenState
    extends State<TrainingCoursesTrainerScreen> {
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
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                    ),
                    backgroundColor: AppColors.white,
                    validator: (value) {
                      return null; // Replace with your validation logic
                    },
                  ),
                ),
                SizedBox(width: 16.w), // Space between search and dropdown
                // Dropdown
                Expanded(
                  flex: 2,
                  child: CustomButton(
                    height: 27.h,
                    labelText: 'إنشاء دورة جديدة',
                    icon: Icons.add,
                    radius: 58.r,
                    buttonColor: AppColors.background,
                    textColor: AppColors.primary,
                    onTap: () {},
                    textFontSize: 8.sp,
                    borderColor: AppColors.primary,
                    fontWeight: FontWeightHelper.light,
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
                        AppRoute.trainerCourseDetails,
                        pathParameters: {'courseId': '123'},
                      );
                    },
                    child: CourseCard(
                      title: 'مهارات أخصائي محاسبة',
                      hours: 'عدد الساعات : 7 ساعات',
                      lectures: 'عدد المحاضرات: 42',
                      actions: [
                        Expanded(
                          child: CustomButton(
                            height: 27.h,
                            radius: 58.r,
                            labelText: 'تعديل الدورة التدريبية',
                            buttonColor: AppColors.background,
                            textColor: AppColors.primary,
                            borderColor: AppColors.orange,
                            onTap: () {},
                            textFontSize: 8.sp,
                            fontWeight: FontWeightHelper.light,
                          ),
                        ),
                      ],
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
