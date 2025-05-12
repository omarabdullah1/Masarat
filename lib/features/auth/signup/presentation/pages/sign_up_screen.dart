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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isPasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // Arabic RTL support
      child: CustomScaffold(
        backgroundColor: AppColors.background,
        haveAppBar: true,
        body: Column(
          children: [
            // Fixed Header
            _buildHeader(),
            // Scrollable Form
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    children: [
                      Gap(20.h),
                      _buildFormFields(),
                      Gap(20.h),
                      _buildEditButton(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Gap(30.h),
        SvgPicture.asset(
          AppImage.iconAppWithTextGreen,
          height: 60.h,
          semanticsLabel: 'Professional Tracks Logo',
        ),
        Gap(20.h),
        CustomText(
          text: 'مرحباً بك !',
          style: TextStyles.font24GreenBold,
          textAlign: TextAlign.center,
        ),
        Gap(10.h),
        CustomText(
          text: 'من فضلك قم بإدخال جميع البيانات\n'
              'المطلوبة حتى تتمكن من إنشاء حساب بنجاح',
          style: TextStyles.font12GrayLight,
          textAlign: TextAlign.center,
        ),
        Gap(5.h),
      ],
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        _buildFormField(
          label: 'الاسم بالكامل',
          hintText: 'أدخل الاسم الكامل',
          validator: AppValidator.emptyValidator,
        ),
        _buildFormField(
          label: 'رقم التواصل',
          hintText: 'أدخل رقم التواصل',
          validator: AppValidator.phoneValidator,
        ),
        _buildFormField(
          label: 'الدرجة العلمية',
          hintText: 'أدخل الدرجة العلمية',
          validator: AppValidator.emptyValidator,
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.upload),
          ),
          enabled: false,
        ),
        _buildFormField(
          label: 'الهوية',
          hintText: 'أدخل رقم الهوية',
          validator: AppValidator.emptyValidator,
        ),
        _buildPasswordField(),
        _buildFormField(
          label: 'تأكيد كلمة السر',
          hintText: 'أعد إدخال كلمة السر',
          isObscureText: true,
          validator: AppValidator.passwordValidator,
        ),
      ],
    );
  }

  Widget _buildFormField({
    required String label,
    required String hintText,
    required String? Function(String?) validator,
    Widget? suffixIcon,
    bool? enabled,
    bool isObscureText = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: CustomText(
              text: label,
              style: TextStyles.font12GrayRegular,
            ),
          ),
          Gap(5.h),
          AppTextFormField(
            hintText: hintText,
            validator: validator,
            enabled: enabled,
            backgroundColor: AppColors.withe,
            isObscureText: isObscureText,
            suffixIcon: suffixIcon,
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: CustomText(
              text: 'كلمة السر',
              style: TextStyles.font12GrayRegular,
            ),
          ),
          Gap(5.h),
          AppTextFormField(
            hintText: 'أدخل كلمة السر',
            isObscureText: isPasswordObscured,
            validator: AppValidator.passwordValidator,
            backgroundColor: AppColors.withe,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isPasswordObscured = !isPasswordObscured;
                });
              },
              child: Icon(
                isPasswordObscured ? Icons.visibility_off : Icons.visibility,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: CustomButton(
        onTap: () {
          // Handle sign-up logic
        },
        height: 45.h,
        labelText: 'إنشاء الحساب',
        textFontSize: 16.sp,
        textColor: AppColors.withe,
      ),
    );
  }
}
