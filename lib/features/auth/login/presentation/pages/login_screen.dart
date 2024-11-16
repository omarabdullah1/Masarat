import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:masarat/core/constants/validators.dart';
import 'package:masarat/core/theme/styles.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/utils/assets_mangment.dart';
import 'package:masarat/core/widgets/CustomScaffold.dart';
import 'package:masarat/core/widgets/app_text_form_field.dart';
import 'package:masarat/core/widgets/custom_button.dart';
import 'package:masarat/core/widgets/custom_text.dart';
import 'package:masarat/features/auth/login/presentation/pages/forgot_password_screen.dart';
import 'package:masarat/features/auth/signup/presentation/pages/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

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
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(30.h),
              SvgPicture.asset(
                AppImage.iconAppWithTextGreen,
                height: 60.h,
                semanticsLabel: 'Professional Tracks Logo',
              ),
              Gap(40.h),
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
              Gap(20.h),
              Align(
                alignment: Alignment.centerRight,
                child: CustomText(
                  text: 'البريد الالكتروني',
                  style: TextStyles.font12GrayRegular,
                ),
              ),
              AppTextFormField(
                hintText: "mail@email.com",
                validator: AppValidator.emailValidator,
                backgroundColor: AppColors.withe,
              ),
              Gap(10.h),
              Align(
                alignment: Alignment.centerRight,
                child: CustomText(
                  text: 'كلمة السر',
                  style: TextStyles.font12GrayRegular,
                ),
              ),
              AppTextFormField(
                hintText: "••••••••",
                isObscureText: isObscureText,
                validator: AppValidator.passwordValidator,
                backgroundColor: AppColors.withe,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isObscureText = !isObscureText;
                    });
                  },
                  child: Icon(
                    isObscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
              Gap(10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        activeColor: AppColors.primary,
                        value: rememberMe,
                        onChanged: (bool? value) {
                          setState(() {
                            rememberMe = !rememberMe;
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
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen(),));
                    },
                    child: CustomText(
                      text: 'نسيت كلمة السر',
                      style: TextStyles.font10rangeRegular.copyWith(
                        decoration: TextDecoration.underline
                        ,
                      ),
                    ),
                  ),
                ],
              ),
              Gap(10.h),
              CustomButton(
                height: 45,

                onTap: () {
                  // Handle login logic
                },

                labelText: 'تسجيل الدخول',
                textFontSize: 16.sp,
                textColor: AppColors.withe,

              ),

              Gap(30.h),
              Row(
                children: [
                  Expanded(
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
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: AppColors.gray,
                    ),
                  ),
                ],
              ),


              Gap(20.h),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => SignUpScreen(),));

                },
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: 'ليس لديك حساب؟ ',
                          style: TextStyles.font13GrayRegular
                      ),
                      TextSpan(
                        text: 'سجل الآن',
                        style: TextStyles.font14DarkBlackRegular.copyWith(
                          decoration: TextDecoration.underline,
                        ),),
                    ],),),

              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _socialLoginButton(String iconPath) {
    return Container(
      width: 60.w,
      height: 60.w,
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gray),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: SvgPicture.asset(
        iconPath,
        fit: BoxFit.contain,
      ),
    );
  }
}
