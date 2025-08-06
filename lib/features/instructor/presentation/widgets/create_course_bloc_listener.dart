import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:go_router/go_router.dart';
import 'package:masarat/config/app_route.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/widgets/loading_widget.dart';
import 'package:masarat/core/widgets/styled_toast.dart';
import 'package:masarat/features/instructor/logic/create_course/create_course_cubit.dart';
import 'package:masarat/features/instructor/logic/create_course/create_course_state.dart';
import 'package:masarat/features/instructor/logic/instructor_courses/instructor_courses_cubit.dart';

class CreateCourseBlocListener extends StatelessWidget {
  final bool isEditMode;
  const CreateCourseBlocListener({super.key, this.isEditMode = false});

  @override
  Widget build(BuildContext context) {
    log('message $isEditMode');
    return BlocListener<CreateCourseCubit, CreateCourseState>(
      listenWhen: (previous, current) =>
          current is Loading ||
          current is CreateCourseSuccess ||
          current is Error,
      listener: (context, state) {
        log('CreateCourseBlocListener state: $state');
        state.whenOrNull(
          loading: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                  child: LoadingWidget(
                    loadingState: true,
                  ),
                ),
              );
            });
          },
          success: (courseResponse) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop(); // Dismiss loading dialog
              showToastWidget(
                StyledToastWidget(
                  message: isEditMode
                      ? "تم تحديث الدورة بنجاح"
                      : "تم إنشاء الدورة بنجاح",
                  icon: Icons.check_circle_outline,
                  color: AppColors.primary,
                ),
                context: context,
                axis: Axis.horizontal,
                alignment: Alignment.center,
                position: StyledToastPosition.top,
                reverseAnimation: StyledToastAnimation.slideFromTopFade,
                animation: StyledToastAnimation.slideFromTopFade,
                duration: const Duration(milliseconds: 2500),
              );
              // Navigate to instructor home screen after success
              if (context.mounted) {
                GoRouter.of(context).go(AppRoute.instructorCoursesManagement);
                // Ensure InstructorCoursesCubit is available in the widget tree
                // before attempting to read it.
                // This typically means it should be provided higher up in the widget tree.
                // For example, in a MultiBlocProvider or a direct BlocProvider.
                // If it's already provided, this line should work.
                // If not, you need to add BlocProvider<InstructorCoursesCubit> somewhere above this widget.
                try {
                  context.read<InstructorCoursesCubit>().getPublishedCourses();
                } catch (e) {
                  log('Error: Could not find InstructorCoursesCubit: $e');
                  // Optionally, show a user-friendly error or handle it gracefully
                }
              }
            });
          },
          error: (error) {
            log('Course creation error: $error');
            setupErrorState(context, error);
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }

  void setupErrorState(BuildContext context, String error) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pop(); // Dismiss loading dialog
      showToastWidget(
        StyledToastWidget(
          message: error,
          icon: Icons.error_outline,
          color: Colors.red,
        ),
        context: context,
        axis: Axis.horizontal,
        alignment: Alignment.center,
        position: StyledToastPosition.top,
        reverseAnimation: StyledToastAnimation.slideFromTopFade,
        animation: StyledToastAnimation.slideFromTopFade,
        duration: const Duration(milliseconds: 2500),
      );
    });
  }
}
