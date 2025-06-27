import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'dart:developer';

import '../../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/styled_toast.dart';
import '../logic/cubit/register_cubit.dart';
import '../logic/cubit/register_state.dart';

class RegisterBlocListener extends StatelessWidget {
  const RegisterBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listenWhen: (previous, current) =>
          current is Loading || current is RegisterSuccess || current is Error,
      listener: (context, state) {
        log('RegisterBlocListener state: $state');
        state.whenOrNull(
          loading: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                context: context,
                builder: (context) => const LoadingWidget(
                  loadingState: true,
                ),
              );
            });
          },
          success: (registerResponse) {
            log('Register success: $registerResponse');
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            });
            showToastWidget(
              StyledToastWidget(
                message: registerResponse.message,
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
          },
          error: (error) {
            log('Register error: $error');
            setupErrorState(context, error);
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }

  void setupErrorState(BuildContext context, String error) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pop();
      showToastWidget(
        StyledToastWidget(
          message: error,
          icon: Icons.error_outline,
          color: AppColors.red.withGreen(20).withBlue(20).withRed(230),
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
