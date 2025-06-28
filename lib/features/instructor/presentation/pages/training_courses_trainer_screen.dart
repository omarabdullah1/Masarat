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
import 'package:masarat/features/instructor/data/models/course/course_model.dart';
import 'package:masarat/features/instructor/logic/instructor_courses/instructor_courses_cubit.dart';
import 'package:masarat/features/instructor/logic/instructor_courses/instructor_courses_state.dart';
import 'package:masarat/features/instructor/presentation/widgets/published_courses_bloc_listener.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/widgets/app_text_form_field.dart';
import '../../../../core/widgets/course_card_widget.dart';
import '../../../../core/widgets/custom_drawer.dart';

class TrainingCoursesTrainerScreen extends StatefulWidget {
  const TrainingCoursesTrainerScreen({super.key});

  @override
  State<TrainingCoursesTrainerScreen> createState() =>
      _TrainingCoursesTrainerScreenState();
}

class _TrainingCoursesTrainerScreenState
    extends State<TrainingCoursesTrainerScreen> {
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
                                    // Edit course action
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
                    final List<CourseModel> filteredCourses =
                        _searchQuery.isEmpty
                            ? coursesResponse.courses
                            : coursesResponse.courses
                                .where((course) => course.title
                                    .toLowerCase()
                                    .contains(_searchQuery.toLowerCase()))
                                .toList();

                    return RefreshIndicator(
                      onRefresh: () async {
                        await context
                            .read<InstructorCoursesCubit>()
                            .getPublishedCourses();
                      },
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        itemCount: filteredCourses.length,
                        itemBuilder: (context, index) {
                          final course = filteredCourses[index];
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
                              image: InstructorApiConstants.imageUrl(course
                                      .coverImageUrl
                                      .contains('default_course_cover')
                                  ? 'uploads/${course.coverImageUrl}'
                                  : course
                                      .coverImageUrl), // Use the course image URL
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
                                      // Edit course action
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
}
