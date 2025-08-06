import 'package:custom_loading/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:go_router/go_router.dart';
import 'package:masarat/config/app_route.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/widgets/app_text_form_field.dart';
import 'package:masarat/core/widgets/custom_button.dart';
import 'package:masarat/core/widgets/loading_widget.dart';
import 'package:masarat/features/auth/forget_password/data/models/reset_password_otp_request_body.dart';
import 'package:masarat/features/auth/forget_password/logic/cubit/forget_password_cubit.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  String? _enteredOtp;
  late final TextEditingController _newPasswordController =
      TextEditingController();
  late final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
            context.goNamed(AppRoute.onboarding);
          },
          error: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(error.toString())),
            );
          },
        );
      },
      child: BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
        builder: (context, state) {
          return CustomLoadingScaffold(
            isLoading:
                state.maybeWhen(loading: () => true, orElse: () => false),
            loaderWidget: const LoadingWidget(loadingState: true),
            backgroundColor: AppColors.transparent,
            body: Scaffold(
              appBar: AppBar(
                title: const Text('OTP Verification'),
              ),
              body: Directionality(
                textDirection: TextDirection.ltr,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        OtpTextField(
                          numberOfFields: 6,
                          borderColor: AppColors.primary,
                          focusedBorderColor: AppColors.primary,
                          fillColor: AppColors.primary,
                          cursorColor: AppColors.primary,
                          showFieldAsBox: true,
                          onCodeChanged: (String code) {
                            _enteredOtp = code;
                          },
                          onSubmit: (String verificationCode) {
                            _enteredOtp = verificationCode;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        AppTextFormField(
                          controller: _newPasswordController,
                          hintText: 'New Password',
                          isObscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a new password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        AppTextFormField(
                          controller: _confirmPasswordController,
                          hintText: 'Confirm New Password',
                          isObscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your new password';
                            }
                            if (value != _newPasswordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24.0),
                        CustomButton(
                          labelText: 'Reset Password',
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              context
                                  .read<ForgetPasswordCubit>()
                                  .resetPasswordWithOtp(
                                    ResetPasswordOtpRequestBody(
                                      email: context
                                          .read<ForgetPasswordCubit>()
                                          .email,
                                      otp: _enteredOtp ?? '',
                                      newPassword: _newPasswordController.text,
                                    ),
                                  );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
