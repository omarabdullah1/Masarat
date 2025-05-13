import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:masarat/core/constants/validators.dart';
import 'package:masarat/core/theme/styles.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/utils/assets_mangment.dart';
import 'package:masarat/core/widgets/app_text_form_field.dart';
import 'package:masarat/core/widgets/custom_button.dart';
import 'package:masarat/core/widgets/custom_scaffold.dart';
import 'package:masarat/core/widgets/custom_text.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // Ensure RTL for Arabic
      child: CustomScaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
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
          hintText: 'example@email.com',
          validator: AppValidator.emailValidator,
          backgroundColor: AppColors.white,
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return CustomButton(
      onTap: () {
        // Handle forgot password logic
      },
      height: 45.h,
      labelText: 'إرسال رابط لإعادة تعيين كلمة السر',
      textFontSize: 16.sp,
      textColor: AppColors.white,
    );
  }
}
