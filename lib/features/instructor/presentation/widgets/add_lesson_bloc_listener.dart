import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/widgets/loading_widget.dart';
import 'package:masarat/features/instructor/logic/add_lesson/add_lesson_cubit.dart';
import 'package:masarat/features/instructor/logic/add_lesson/add_lesson_state.dart';

class AddLessonBlocListener extends StatelessWidget {
  const AddLessonBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddLessonCubit, AddLessonState>(
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
        log('AddLessonBlocListener state: $state');

        state.maybeWhen(
          loading: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                  child: LoadingWidget(
                    loadingState: true,
                    backgroundColor: AppColors.transparent,
                  ),
                ),
              );
            });
          },
          success: (data) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // Close any loading dialog if it's open
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }

              // Show success message
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم إضافة الدرس بنجاح'),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 3),
                ),
              );

              // Navigate back to course details
              Navigator.of(context).pop();
            });
          },
          error: (error) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // Close any loading dialog if it's open
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }

              // Show error message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('خطأ في إضافة الدرس: $error'),
                  backgroundColor: AppColors.red,
                  duration: const Duration(seconds: 4),
                ),
              );
            });
          },
          orElse: () {},
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
