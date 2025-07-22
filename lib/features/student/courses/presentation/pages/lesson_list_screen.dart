import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:masarat/config/app_route.dart';
import 'package:masarat/core/di/dependency_injection.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/utils/image_url_helper.dart';
import 'package:masarat/core/widgets/custom_scaffold.dart';
import 'package:masarat/core/widgets/custom_text.dart';
import 'package:masarat/features/student/courses/data/models/course_model.dart';
import 'package:masarat/features/student/courses/data/models/lesson_model.dart';
import 'package:masarat/features/student/courses/logic/cubit/student_lessons_cubit.dart';
import 'package:masarat/features/student/courses/logic/cubit/student_lessons_state.dart';
import 'package:masarat/features/student/courses/services/course_state_service.dart';

class LessonListScreen extends StatefulWidget {
  const LessonListScreen({this.course, super.key});

  final CourseModel? course;

  @override
  State<LessonListScreen> createState() => _LessonListScreenState();
}

class _LessonListScreenState extends State<LessonListScreen> {
  StudentLessonsCubit? _lessonsCubit;
  bool _hasCubitError = false;

  @override
  void initState() {
    super.initState();

    try {
      _lessonsCubit = getIt<StudentLessonsCubit>();

      // Load lessons from the API when the screen loads
      if (widget.course != null) {
        _loadLessons();
      }
    } catch (e) {
      print('Error initializing StudentLessonsCubit: $e');
      _hasCubitError = true;
    }
  }

  void _loadLessons() {
    try {
      if (_lessonsCubit != null) {
        _lessonsCubit!.getLessons(widget.course!.id);
      }
    } catch (e) {
      print('Error loading lessons: $e');
      _hasCubitError = true;
    }
  }

  @override
  void dispose() {
    _lessonsCubit?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // If we don't have course data, show error
    if (widget.course == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('محاضرات الدورة'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: const Center(
          child: Text(
            'بيانات الدورة غير متوفرة. يرجى العودة والمحاولة مرة أخرى.',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    // If we couldn't initialize the cubit, wrap the screen with a provider
    if (_hasCubitError || _lessonsCubit == null) {
      try {
        _lessonsCubit = getIt<StudentLessonsCubit>();
      } catch (e) {
        debugPrint('Still cannot get StudentLessonsCubit: $e');
        // Continue with the UI anyway, we'll fall back to course.lessons
      }
    }

    // If we have an error with the cubit, just show the screen without BlocProvider
    if (_hasCubitError || _lessonsCubit == null) {
      return _buildScaffold();
    }

    return BlocProvider<StudentLessonsCubit>(
      create: (context) => _lessonsCubit!,
      child: _buildScaffold(),
    );
  }

  Widget _buildScaffold() {
    return CustomScaffold(
      haveAppBar: true,
      backgroundColorAppColor: AppColors.background,
      backgroundColor: AppColors.background,
      drawerIconColor: AppColors.primary,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image and title
              Center(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: ImageUrlHelper.formatImageUrl(
                            widget.course!.coverImageUrl),
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          height: 180,
                          color: Colors.grey[300],
                          child:
                              const Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) => Container(
                          height: 180,
                          color: Colors.grey[300],
                          child: const Icon(Icons.error_outline, size: 40),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      widget.course!.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'عدد الساعات: ${widget.course!.durationEstimate}',
                      style: const TextStyle(color: AppColors.gray),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'عدد المحاضرات: ${widget.course!.lessons.length}',
                      style: const TextStyle(color: AppColors.primary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Lessons list with BlocBuilder
              BlocBuilder<StudentLessonsCubit, StudentLessonsState>(
                builder: (context, state) {
                  switch (state.status) {
                    case StudentLessonsStatus.loading:
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    case StudentLessonsStatus.success:
                      // If API returns lessons, use those instead of the model
                      return _buildLessonsList(state.lessons!);
                    case StudentLessonsStatus.error:
                      // On error, show error message and fallback to course model
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'خطأ في تحميل المحاضرات: ${state.errorMessage}',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          _buildLessonsList(widget.course!.lessons),
                        ],
                      );
                    case StudentLessonsStatus.initial:
                      // When we haven't loaded lessons yet
                      // Show the default lessons from the course model
                      return _buildLessonsList(widget.course!.lessons);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLessonsList(List<LessonModel> lessons) {
    if (lessons.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            'لا توجد محاضرات متاحة لهذه الدورة',
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: lessons.length,
      itemBuilder: (context, index) {
        final lesson = lessons[index];
        return InkWell(
          onTap: () {
            // Before navigation, ensure the current API lessons are stored in CourseStateService
            try {
              if (_lessonsCubit != null) {
                final currentState = _lessonsCubit!.state;
                if (currentState.status == StudentLessonsStatus.success &&
                    currentState.lessons != null) {
                  final courseService = getIt<CourseStateService>();
                  courseService.storeLessonsForCourse(
                      widget.course!.id, currentState.lessons!);
                  debugPrint(
                      'Stored updated lessons in CourseStateService before navigation');
                }
              }
            } catch (e) {
              debugPrint('Error storing lessons before navigation: $e');
            }

            context.goNamed(
              AppRoute.lectureDetails,
              pathParameters: {
                'courseid': widget.course!.id,
                'lectureid': lesson.id,
              },
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0.h),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: index == 0 ? AppColors.primary : Colors.grey[300]!,
                ),
                borderRadius: BorderRadius.circular(4.r),
                color: index == 0 ? Colors.white : Colors.grey[300],
              ),
              width: double.infinity,
              height: 40.h,
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Padding(
                  padding: EdgeInsets.all(8.0.r),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          text: 'المحاضرة ${index + 1}: ${lesson.title}',
                        ),
                      ),
                      if (lesson.isPreviewable == true)
                        const Icon(
                          Icons.visibility,
                          color: AppColors.primary,
                          size: 16,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
