import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:masarat/config/app_route.dart';
import 'package:masarat/core/theme/font_weight_helper.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/widgets/custom_button.dart';
import 'package:masarat/core/widgets/custom_scaffold.dart';
import 'package:masarat/core/widgets/custom_text.dart';
import 'package:masarat/features/instructor/data/apis/instructor_api_constants.dart';
import 'package:masarat/features/instructor/data/models/course/course_model.dart'
    as instructor;
import 'package:masarat/features/instructor/logic/instructor_courses/instructor_courses_cubit.dart';
import 'package:masarat/features/instructor/logic/instructor_courses/instructor_courses_state.dart';
import 'package:masarat/features/instructor/presentation/widgets/published_courses_bloc_listener.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/widgets/app_text_form_field.dart';
import '../../../../../core/widgets/course_card_widget.dart';
import '../../../../../core/widgets/custom_drawer.dart';

class InstructorHomeScreen extends StatefulWidget {
  const InstructorHomeScreen({super.key});

  @override
  State<InstructorHomeScreen> createState() => _InstructorHomeScreenState();
}

class _InstructorHomeScreenState extends State<InstructorHomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Load published courses on screen initialization
    context.read<InstructorCoursesCubit>().getPublishedCourses();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      haveAppBar: true,
      backgroundColorAppColor: AppColors.background,
      backgroundColor: AppColors.background,
      drawerIconColor: AppColors.primary,
      drawer: const CustomDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Add PublishedCoursesBlocListener for showing loading and error states
          const PublishedCoursesBlocListener(),

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
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _searchQuery = _searchController.text;
                      });
                    },
                    icon: const Icon(Icons.search),
                  ),
                  backgroundColor: AppColors.white,
                  validator: (value) {
                    return null;
                  },
                ),
              ),
              SizedBox(width: 16.w), // Space between search and button
              // Create new course button
              Expanded(
                flex: 2,
                child: CustomButton(
                  height: 27.h,
                  labelText: 'إنشاء دورة جديدة',
                  icon: Icons.add,
                  radius: 58.r,
                  buttonColor: AppColors.background,
                  textColor: AppColors.primary,
                  onTap: () {
                    context.goNamed(AppRoute.createCourse);
                  },
                  textFontSize: 8.sp,
                  borderColor: AppColors.primary,
                  fontWeight: FontWeightHelper.light,
                ),
              ),
            ],
          ),
          Gap(24.h), // Space after row

          // Course Cards List
          Expanded(
            child: BlocBuilder<InstructorCoursesCubit, InstructorCoursesState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loading: () => Skeletonizer(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            context.goNamed(
                              AppRoute.trainerCourseDetails,
                              pathParameters: {'courseid': 'course'},
                            );
                          },
                          child: CourseCard(
                            title: '',
                            hours: 'عدد الساعات: 0',
                            lectures: 'المستوى: مبتدئ',
                            image: '', // Use the course image URL
                            actions: [
                              Expanded(
                                child: CustomButton(
                                  height: 27.h,
                                  radius: 58.r,
                                  labelText: 'تعديل الدورة التدريبية',
                                  buttonColor: AppColors.background,
                                  textColor: AppColors.primary,
                                  borderColor: AppColors.orange,
                                  onTap: () {
                                    // Edit course action - skeleton/loading state
                                  },
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
                  success: (coursesResponse) {
                    if (coursesResponse.courses.isEmpty) {
                      return Center(
                        child: CustomText(
                          text: 'لا توجد دورات منشورة',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.gray,
                          ),
                        ),
                      );
                    }

                    // Filter courses if search query is not empty
                    final List<instructor.CourseModel> filteredCourses =
                        _searchQuery.isEmpty
                            ? coursesResponse.courses
                            : coursesResponse.courses
                                .where((course) => course.title
                                    .toLowerCase()
                                    .contains(_searchQuery.toLowerCase()))
                                .toList();

                    return RefreshIndicator(
                      color: AppColors.primary,
                      onRefresh: () async {
                        await context
                            .read<InstructorCoursesCubit>()
                            .getPublishedCourses();
                      },
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        itemCount: filteredCourses.length,
                        itemBuilder: (context, index) {
                          final instructor.CourseModel course =
                              filteredCourses[index];
                          return GestureDetector(
                            onTap: () {
                              context.goNamed(
                                AppRoute.trainerCourseDetails,
                                pathParameters: {'courseid': course.id},
                              );
                            },
                            child: CourseCard(
                              title: course.title,
                              hours: 'عدد الساعات: ${course.durationEstimate}',
                              lectures:
                                  'المستوى: ${_getArabicLevel(course.level)}',
                              image: InstructorApiConstants.imageUrl(
                                  course.coverImageUrl),
                              verificationStatus: course.verificationStatus,
                              actions: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: CustomButton(
                                          height: 27.h,
                                          radius: 58.r,
                                          labelText: 'تعديل الدورة التدريبية',
                                          buttonColor: AppColors.background,
                                          textColor: AppColors.primary,
                                          borderColor: AppColors.orange,
                                          onTap: () {
                                            log('Navigating to edit course with data: $course');
                                            context.goNamed(
                                              AppRoute.editCourseName,
                                              extra: course,
                                            );
                                          },
                                          textFontSize: 8.sp,
                                          fontWeight: FontWeightHelper.light,
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      Expanded(
                                        flex: 1,
                                        child: GestureDetector(
                                          onTap: () {
                                            _showDeleteConfirmationDialog(
                                                context, course);
                                          },
                                          child: Container(
                                            height: 27.h,
                                            decoration: BoxDecoration(
                                              color: AppColors.background,
                                              borderRadius:
                                                  BorderRadius.circular(58.r),
                                              border: Border.all(
                                                  color: AppColors.red),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.delete_outline,
                                                color: AppColors.red,
                                                size: 16.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                  error: (errorMessage) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: 'خطأ في تحميل الدورات: $errorMessage',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.red,
                          ),
                        ),
                        Gap(16.h),
                        CustomButton(
                          height: 40.h,
                          labelText: 'إعادة المحاولة',
                          buttonColor: AppColors.primary,
                          textColor: AppColors.white,
                          onTap: () {
                            context
                                .read<InstructorCoursesCubit>()
                                .getPublishedCourses();
                          },
                          radius: 8.r,
                        ),
                      ],
                    ),
                  ),
                  orElse: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to convert English level to Arabic
  String _getArabicLevel(String level) {
    switch (level.toLowerCase()) {
      case 'beginner':
        return 'مبتدئ';
      case 'intermediate':
        return 'متوسط';
      case 'advanced':
        return 'متقدم';
      default:
        return level;
    }
  }

  // Show confirmation dialog before deleting a course
  void _showDeleteConfirmationDialog(
      BuildContext context, instructor.CourseModel course) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const CustomText(
            text: 'حذف الدورة التدريبية',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: CustomText(
            text: 'هل أنت متأكد من حذف الدورة التدريبية "${course.title}"؟',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
              },
              child: const CustomText(
                text: 'إلغاء',
                style: TextStyle(color: AppColors.primary),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop(); // Close the dialog

                // Show loading indicator
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('جاري حذف الدورة...'),
                    duration: Duration(seconds: 2),
                  ),
                );

                // Call the delete method from the cubit
                final success = await context
                    .read<InstructorCoursesCubit>()
                    .deleteCourse(course.id);

                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('تم حذف الدورة بنجاح'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('فشل في حذف الدورة'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const CustomText(
                text: 'حذف',
                style: TextStyle(color: AppColors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
