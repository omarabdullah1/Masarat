import 'package:custom_loading/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:masarat/config/app_route.dart';
import 'package:masarat/core/constants/validators.dart';
import 'package:masarat/core/di/dependency_injection.dart';
import 'package:masarat/core/theme/styles.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/utils/assets_mangment.dart';
import 'package:masarat/core/widgets/app_text_form_field.dart';
import 'package:masarat/core/widgets/custom_scaffold.dart';
import 'package:masarat/core/widgets/custom_text.dart';
import 'package:masarat/core/widgets/loading_widget.dart';
import 'package:masarat/features/auth/forget_password/data/models/send_otp_request_body.dart';
import 'package:masarat/features/auth/forget_password/logic/cubit/forget_password_cubit.dart';

import '../../../../../core/widgets/custom_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ForgetPasswordCubit>(),
      child: BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          state.whenOrNull(
            success: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
              context.pushNamed(AppRoute.otpVerificationScreen,
                  extra: context.read<ForgetPasswordCubit>().email);
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
                body: Directionality(
                  textDirection: TextDirection.rtl, // Ensure RTL for Arabic
                  child: CustomScaffold(
                    body: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Gap(60.h),
                            _buildLogo(),
                            Gap(40.h),
                            _buildTitle(),
                            Gap(10.h),
                            _buildInstructions(),
                            Gap(20.h),
                            _buildEmailField(),
                            Gap(25.h),
                            _buildSubmitButton(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
          },
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return SvgPicture.asset(
      AppImage.iconAppWithTextGreen,
      height: 60.h,
      semanticsLabel: 'Professional Tracks Logo',
    );
  }

  Widget _buildTitle() {
    return CustomText(
      text: 'هل نسيت كلمة السر؟',
      style: TextStyles.font24GreenBold,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildInstructions() {
    return CustomText(
      text: 'من فضلك قم بإدخال البريد الإلكتروني ثم توجه إلى الرابط المرسل\n'
          'لإعادة تعيين كلمة السر الخاصة بك',
      style: TextStyles.font12GrayLight,
      textAlign: TextAlign.center,
      overflow: TextOverflow.visible,
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'البريد الإلكتروني',
          style: TextStyles.font12GrayRegular,
        ),
        Gap(5.h),
        AppTextFormField(
          controller: _emailController,
          hintText: 'example@email.com',
          validator: AppValidator.emailValidator,
          backgroundColor: AppColors.white,
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Builder(
      builder: (context) {
        return CustomButton(
          onTap: () {
            if (_formKey.currentState!.validate()) {
              context.read<ForgetPasswordCubit>().sendOtp(
                    SendOtpRequestBody(
                      email: _emailController.text,
                      type: 'password-reset',
                    ),
                  );
            }
          },
          height: 45.h,
          labelText: 'إرسال رابط لإعادة تعيين كلمة السر',
          textFontSize: 16.sp,
          textColor: AppColors.white,
        );
      },
    );
  }
}
