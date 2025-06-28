import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
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
import 'package:masarat/features/student/courses/logic/training_courses/training_courses_cubit.dart';
import 'package:masarat/features/student/courses/logic/training_courses/training_courses_state.dart';

class TrainingCoursesScreen extends StatefulWidget {
  const TrainingCoursesScreen({super.key});

  @override
  State<TrainingCoursesScreen> createState() => _TrainingCoursesScreenState();
}

class _TrainingCoursesScreenState extends State<TrainingCoursesScreen> {
  String? selectedOption; // Moved outside build to retain state
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<TrainingCoursesCubit>()..getCourses(),
      child: CustomScaffold(
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
                      controller: _searchController,
                      hintText: 'بحث عن الدورات التدريبية ...',
                      backgroundColor: AppColors.white,
                      validator: (value) {
                        return null; // Replace with your validation logic
                      },
                      onSubmit: (value) {
                        // Implement search functionality
                        context
                            .read<TrainingCoursesCubit>()
                            .searchCourses(value);
                      },
                    ),
                  ),
                  SizedBox(width: 16.w), // Space between search and dropdown
                  // Dropdown
                  Expanded(
                    flex: 2,
                    child: CustomDropdownButton(
                      items: const ['الكل', 'مبتدئ', 'متوسط', 'متقدم'],
                      hintText: 'فلترة حسب المستوى',
                      onChanged: (value) {
                        log('Selected Level: $value');
                        final level = value == 'الكل' ? null : value;
                        context
                            .read<TrainingCoursesCubit>()
                            .updateFilters(level: level);
                      },
                    ),
                  ),
                ],
              ),
              Gap(24.h), // Space after row
              Expanded(
                child: BlocBuilder<TrainingCoursesCubit, TrainingCoursesState>(
                  builder: (context, state) {
                    return state.when(
                      initial: () => const Center(
                        child: Text('ابدأ البحث عن الدورات'),
                      ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      success: (courses) {
                        if (courses.isEmpty) {
                          return const Center(
                            child: Text('لا توجد دورات متاحة'),
                          );
                        }
                        return ListView.builder(
                          itemCount: courses.length,
                          itemBuilder: (context, index) {
                            final course = courses[index];
                            return GestureDetector(
                              onTap: () {
                                context.goNamed(
                                  AppRoute.courseDetails,
                                  pathParameters: {'courseid': course.id},
                                );
                              },
                              child: CourseCard(
                                title: course.title,
                                hours:
                                    'عدد الساعات : ${course.durationEstimate}',
                                lectures:
                                    'عدد المحاضرات: ${course.lessons.length}',
                                actions: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: CustomButton(
                                            height: 27.h,
                                            radius: 58.r,
                                            labelText:
                                                'شــراء بـ ${course.price} ر.س',
                                            buttonColor: AppColors.primary,
                                            textColor: AppColors.white,
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
                        );
                      },
                      error: (message) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'حدث خطأ: $message',
                              textAlign: TextAlign.center,
                            ),
                            Gap(16.h),
                            CustomButton(
                              labelText: 'إعادة المحاولة',
                              onTap: () {
                                context
                                    .read<TrainingCoursesCubit>()
                                    .getCourses();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
