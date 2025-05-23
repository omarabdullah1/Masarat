import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:masarat/config/app_route.dart';
import 'package:masarat/core/constants/validators.dart';
import 'package:masarat/core/helpers/constants.dart';
import 'package:masarat/core/theme/styles.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/utils/assets_mangment.dart';
import 'package:masarat/core/widgets/app_text_form_field.dart';
import 'package:masarat/core/widgets/custom_button.dart';
import 'package:masarat/core/widgets/custom_scaffold.dart';
import 'package:masarat/core/widgets/custom_text.dart';
import 'package:masarat/features/auth/login/logic/cubit/login_cubit.dart';
import 'package:masarat/features/auth/login/logic/cubit/login_state.dart';
import 'package:masarat/features/auth/login/ui/screens/forgot_password_screen.dart';

import '../widgets/login_bloc_listener.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({required this.isTrainer, super.key});
  final bool isTrainer;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscureText = true;
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // Ensure RTL for Arabic text
      child: CustomScaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            children: [
              Gap(30.h),
              _buildLogo(),
              Gap(40.h),
              _buildWelcomeMessage(),
              Gap(20.h),
              _buildEmailField(),
              Gap(10.h),
              _buildPasswordField(),
              Gap(10.h),
              const LoginBlocListener(),
              Gap(10.h),
              _buildRememberMeAndForgotPasswordRow(),
              Gap(10.h),
              _buildLoginButton(),
              Gap(30.h),
              _buildDividerWithText(),
              Gap(20.h),
              _buildSignUpPrompt(),
            ],
          ),
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

  Widget _buildWelcomeMessage() {
    return Column(
      children: [
        CustomText(
          text: 'مرحباً بعودتك !',
          style: TextStyles.font24greyBold,
        ),
        Gap(8.h),
        CustomText(
          text: 'يرجي تسجيل الدخول',
          textAlign: TextAlign.center,
          style: TextStyles.font24greyLight,
        ),
        CustomText(
          text: 'إلى حساب الخاص في المسارات الاحترافية',
          textAlign: TextAlign.center,
          style: TextStyles.font18greyLight,
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'البريد الالكتروني',
          style: TextStyles.font12GrayRegular,
        ),
        AppTextFormField(
          hintText: 'mail@email.com',
          validator: AppValidator.emailValidator,
          backgroundColor: AppColors.white,
          controller: context.read<LoginCubit>().emailController,
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'كلمة السر',
          style: TextStyles.font12GrayRegular,
        ),
        AppTextFormField(
          hintText: '••••••••',
          isObscureText: isObscureText,
          validator: AppValidator.passwordValidator,
          backgroundColor: AppColors.white,
          controller: context.read<LoginCubit>().passwordController,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                isObscureText = !isObscureText;
              });
            },
            child: Icon(
              isObscureText ? Icons.visibility_off : Icons.visibility,
              color: AppColors.primary,
            ),
          ),
          onSubmit: (data) =>
              context.read<LoginCubit>().emitLoginStates(context),
        ),
      ],
    );
  }

  Widget _buildRememberMeAndForgotPasswordRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              activeColor: AppColors.primary,
              value: rememberMe,
              onChanged: (bool? value) {
                setState(() {
                  rememberMe = value ?? false;
                });
              },
            ),
            CustomText(
              text: 'تذكرني لمدة 30 يوم',
              style: TextStyles.font10GrayRegular,
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<ForgotPasswordScreen>(
                builder: (context) => const ForgotPasswordScreen(),
              ),
            );
          },
          child: CustomText(
            text: 'نسيت كلمة السر',
            style: TextStyles.font10rangeRegular.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return CustomButton(
          height: 45.h,
          onTap: () {
            context.read<LoginCubit>().emitLoginStates(context);
            // if (widget.isTrainer) {
            //   context.go(AppRoute.trainingCoursesTrainer);
            // } else {
            //   context.go(AppRoute.home);
            // }
          },
          labelText: 'تسجيل الدخول',
          textFontSize: 16.sp,
          textColor: AppColors.white,
        );
      },
    );
  }

  Widget _buildDividerWithText() {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            thickness: 1,
            color: AppColors.gray,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: CustomText(
            text: 'أو',
            style: TextStyles.font14GrayRegular,
          ),
        ),
        const Expanded(
          child: Divider(
            thickness: 1,
            color: AppColors.gray,
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpPrompt() {
    return GestureDetector(
      onTap: () {
        context.go(AppRoute.signUp);
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'ليس لديك حساب؟ ',
              style: TextStyles.font13GrayRegular,
            ),
            TextSpan(
              text: 'سجل الآن',
              style: TextStyles.font14DarkBlackRegular.copyWith(
                decoration: TextDecoration.underline,
                fontFamily: Constants.fontName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
