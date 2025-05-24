import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/widgets/loading_widget.dart';
import 'package:masarat/core/widgets/styled_toast.dart';
import 'package:masarat/features/courses/logic/cubit/create_course_cubit.dart';
import 'package:masarat/features/courses/logic/cubit/create_course_state.dart';
import 'dart:developer';

class CreateCourseBlocListener extends StatelessWidget {
  const CreateCourseBlocListener({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                builder: (context) => const LoadingWidget(
                  loadingState: true,
                ),
              );
            });
          },
          success: (courseResponse) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop(); // Dismiss loading dialog
              showToastWidget(
                const StyledToastWidget(
                  message: "تم إنشاء الدورة بنجاح",
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
