import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/widgets/loading_widget.dart';
import 'package:masarat/core/widgets/styled_toast.dart';
import 'package:masarat/features/instructor/logic/instructor_courses/instructor_courses_cubit.dart';
import 'package:masarat/features/instructor/logic/instructor_courses/instructor_courses_state.dart';

class PublishedCoursesBlocListener extends StatelessWidget {
  const PublishedCoursesBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<InstructorCoursesCubit, InstructorCoursesState>(
      listenWhen: (previous, current) {
        // Listen for state changes that require UI feedback
        return current.maybeWhen(
          loading: () => true,
          success: (_) => true,
          error: (_) => true,
          orElse: () => false,
        );
      },
      listener: (context, state) {
        log('PublishedCoursesBlocListener state: $state');
        final cubit = context.read<InstructorCoursesCubit>();

        state.maybeWhen(
          loading: () {
            // Only show loading dialog for initial load, not for pagination
            if (cubit.currentPage == 1) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const LoadingWidget(
                    loadingState: true,
                    backgroundColor: AppColors.transparent,
                  ),
                );
              });
            }
          },
          success: (data) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // Close any loading dialog if it's open
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }

              // Check if we have a pagination error to display
              final paginationError = cubit.lastPaginationError;
              if (paginationError != null && cubit.currentPage > 1) {
                // Show toast for pagination errors
                showToastWidget(
                  StyledToastWidget(
                    message: paginationError,
                    icon: Icons.error_outline,
                    color: AppColors.orange,
                  ),
                  context: context,
                  axis: Axis.horizontal,
                  alignment: Alignment.center,
                  position: StyledToastPosition.bottom,
                  animation: StyledToastAnimation.slideFromBottomFade,
                  duration: const Duration(milliseconds: 2000),
                );
              }
            });
          },
          error: (errorString) {
            setupErrorState(context, errorString);
          },
          orElse: () {},
        );
      },
      child: const SizedBox.shrink(),
    );
  }

  void setupErrorState(BuildContext context, String error) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Close any loading dialog if it's open
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }

      showToastWidget(
        StyledToastWidget(
          message: error,
          icon: Icons.error_outline,
          color: AppColors.red,
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
