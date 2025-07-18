import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:masarat/config/app_route.dart';
import 'package:masarat/features/auth/login/data/models/login_response.dart';
import 'package:masarat/features/auth/login/logic/cubit/login_cubit.dart';
import 'package:masarat/features/auth/login/logic/cubit/login_state.dart';

import '../../../../../core/helpers/constants.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/loading_widget.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key, required this.isTrainer});
  final bool isTrainer;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) =>
          current is Loading || current is LoginSuccess || current is Error,
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                context: context,
                builder: (context) => const LoadingWidget(
                  loadingState: true,
                  backgroundColor: AppColors.transparent,
                ),
              );
            });
          },
          success: (dynamic data) {
            final loginResponse = data as LoginResponse;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).popUntil((route) => route.isFirst);
              isLoggedInUser = true;
              if (isTrainer) {
                if (loginResponse.role == 'instructor') {
                  log('User is a trainer, navigating to instructor courses');
                  context.go(AppRoute.instructorCoursesManagement);
                } else if (loginResponse.role == 'student') {
                  log('User is not a trainer, navigating to home');
                  context.go(AppRoute.home);
                }
              } else {
                if (loginResponse.role == 'student') {
                  log('User is a student, navigating to home');
                  context.go(AppRoute.home);
                } else if (loginResponse.role == 'instructor') {
                  log('User is a trainer, navigating to instructor courses');
                  context.go(AppRoute.instructorCoursesManagement);
                }
              }
            });
          },
          error: (error) {
            setupErrorState(context, error);
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }

  void setupErrorState(BuildContext context, String error) {
    final cubit = context.read<LoginCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).popUntil((route) => route.isFirst);
      cubit.snackbarShow(
        context,
        error,
        color: AppColors.red,
      );
    });
  }
}
