import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:masarat/config/app_route.dart';
import 'package:masarat/core/helpers/constants.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/utils/assets_mangment.dart';
import 'package:masarat/core/widgets/custom_button.dart';

class ProfessionalTracksApp extends StatelessWidget {
  const ProfessionalTracksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Gap(
                30.h,
              ),
              SvgPicture.asset(
                AppImage.iconAppWithText,
                height: 60.h,
              ),
              Gap(70.h),
              Text(
                'أهلاً بك  !',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: Constants.fontName,
                ),
              ),
              Gap(8.h),
              Text(
                'في المسارات الاحترافية',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontFamily: Constants.fontName,
                ),
              ),
              Text(
                ' من فضلك قم باختيار طريقة الدخول',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontFamily: Constants.fontName,
                ),
              ),
              Gap(40.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0.w),
                child: Column(
                  children: [
                    CustomButton(
                      labelText: 'مدرب',
                      buttonColor: AppColors.primary,
                      textColor: AppColors.white,
                      borderColor: AppColors.white,
                      textFontSize: 22.sp,
                      borderWidth: 2.w,
                      onTap: () {
                        context.go(AppRoute.login, extra: true);
                      },
                    ),
                    Gap(16.h),
                    CustomButton(
                      labelText: 'متدرب',
                      buttonColor: AppColors.white,
                      textColor: AppColors.primary,
                      onTap: () {
                        context.go(AppRoute.login, extra: false);
                      },
                      textFontSize: 22.sp,
                    ),
                    Gap(16.h),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColors.white,
                            thickness: 1.h,
                            indent: 32.w,
                            endIndent: 8.w,
                          ),
                        ),
                        Text(
                          'أو',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 18.sp,
                            fontFamily: Constants.fontName,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: AppColors.white,
                            thickness: 1.h,
                            indent: 8.w,
                            endIndent: 32.w,
                          ),
                        ),
                      ],
                    ),
                    Gap(16.h),
                    CustomButton(
                      labelText: 'موظف',
                      buttonColor: AppColors.white,
                      textColor: AppColors.gery200,
                      borderColor: AppColors.gery200,
                      borderWidth: 2.w,
                      onTap: () {},
                      textFontSize: 22.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
