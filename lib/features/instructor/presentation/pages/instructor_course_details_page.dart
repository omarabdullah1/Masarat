import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:masarat/core/di/dependency_injection.dart';
import 'package:masarat/core/theme/font_weight_helper.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/widgets/custom_scaffold.dart';
import 'package:masarat/core/widgets/custom_text.dart';
import 'package:masarat/features/courses/presentation/widgets/add_lecture_button_widget.dart';
import 'package:masarat/features/courses/presentation/widgets/add_lecture_form_widget.dart';
import 'package:masarat/features/instructor/data/models/add_lesson/add_lesson_request_body.dart';
import 'package:masarat/features/instructor/logic/add_lesson/add_lesson_cubit.dart';
import 'package:masarat/features/instructor/logic/add_lesson/add_lesson_state.dart';
import 'package:masarat/features/instructor/logic/get_lessons/get_lessons_cubit.dart';
import 'package:masarat/features/instructor/logic/get_lessons/get_lessons_state.dart';
import 'package:masarat/features/instructor/presentation/widgets/lessons_list_widget.dart';

class InstructorCourseDetailsPage extends StatefulWidget {
  const InstructorCourseDetailsPage({required this.courseId, super.key});
  final String courseId;

  @override
  State<InstructorCourseDetailsPage> createState() =>
      _InstructorCourseDetailsPageState();
}

class _InstructorCourseDetailsPageState
    extends State<InstructorCourseDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AddLessonCubit>()),
        BlocProvider(
            create: (context) =>
                getIt<GetLessonsCubit>()..getLessons(widget.courseId)),
      ],
      child: _TrainerCourseDetailsContent(courseId: widget.courseId),
    );
  }
}

class _TrainerCourseDetailsContent extends StatefulWidget {
  const _TrainerCourseDetailsContent({required this.courseId});
  final String courseId;

  @override
  State<_TrainerCourseDetailsContent> createState() =>
      _TrainerCourseDetailsContentState();
}

class _TrainerCourseDetailsContentState
    extends State<_TrainerCourseDetailsContent> {
  // State variables
  bool isAddingLecture = false;
  final TextEditingController courseNameController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController sourceController = TextEditingController();
  final TextEditingController orderController = TextEditingController();
  final TextEditingController durationController = TextEditingController();

  @override
  void dispose() {
    courseNameController.dispose();
    contentController.dispose();
    sourceController.dispose();
    orderController.dispose();
    durationController.dispose();
    super.dispose();
  }

  void addLecture() {
    // Validate required fields
    if (courseNameController.text.isNotEmpty &&
        contentController.text.isNotEmpty &&
        orderController.text.isNotEmpty &&
        durationController.text.isNotEmpty) {
      // Create the add lesson request
      final requestBody = AddLessonRequestBody(
        title: courseNameController.text.trim(),
        contentType: 'video', // Default to video, can be made dynamic
        content: contentController.text.trim(),
        courseId: widget.courseId,
        order: int.tryParse(orderController.text) ?? 1,
        durationEstimate: durationController.text.trim(),
        isPreviewable: false, // Default to false, can be made dynamic
      );

      // Call the BLoC to add the lesson
      context.read<AddLessonCubit>().addLesson(requestBody);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddLessonCubit, AddLessonState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (data) {
            // Hide form after successful lesson addition
            setState(() {
              isAddingLecture = false;
            });

            // Clear controllers
            courseNameController.clear();
            contentController.clear();
            sourceController.clear();
            orderController.clear();
            durationController.clear();

            // Refresh lessons list
            context.read<GetLessonsCubit>().getLessons(widget.courseId);

            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم إضافة الدرس بنجاح'),
                backgroundColor: Colors.green,
              ),
            );
          },
          error: (error) {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('خطأ في إضافة الدرس: $error'),
                backgroundColor: Colors.red,
              ),
            );
          },
          orElse: () {},
        );
      },
      child: CustomScaffold(
        haveAppBar: true,
        backgroundColorAppColor: AppColors.background,
        backgroundColor: AppColors.background,
        drawerIconColor: AppColors.primary,
        showBackButton: true,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                Gap(15.h),
                AddLectureButtonWidget(
                  isAddingLecture: isAddingLecture,
                  toggleAddLecture: () {
                    setState(() {
                      isAddingLecture = !isAddingLecture; // Toggle visibility
                    });
                  },
                ),
                if (isAddingLecture)
                  AddLectureFormWidget(
                    courseNameController: courseNameController,
                    contentController: contentController,
                    sourceController: sourceController,
                    orderController: orderController,
                    durationController: durationController,
                    addLecture: addLecture,
                  ),
                SizedBox(height: 16.h),
                BlocBuilder<GetLessonsCubit, GetLessonsState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      loading: () => const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      ),
                      success: (lessons) => LessonsListWidget(
                        lessons: lessons,
                        onDeleteLesson: (lesson) {
                          // You can implement delete functionality here
                          // For now, just show a message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('حذف الدرس: ${lesson.title}'),
                            ),
                          );
                        },
                      ),
                      error: (error) => Center(
                        child: Column(
                          children: [
                            Text(
                              'Error loading lessons: $error',
                              style: const TextStyle(color: Colors.red),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                context
                                    .read<GetLessonsCubit>()
                                    .getLessons(widget.courseId);
                              },
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                      orElse: () => const SizedBox.shrink(),
                    );
                  },
                ),
              ],
            ),
            // Loading overlay
            BlocBuilder<AddLessonCubit, AddLessonState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loading: () => Container(
                    color: Colors.black.withAlpha((0.3 * 255).toInt()),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  orElse: () => const SizedBox.shrink(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
