import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:masarat/core/helpers/constants.dart';
import 'package:masarat/core/helpers/shared_pref_helper.dart';
import 'package:masarat/core/utils/app_colors.dart';

import '../../../assets/assets.dart';
import '../../../config/app_route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Schedule navigation after splash duration
    Future.delayed(const Duration(seconds: 4), () async {
      if (context.mounted) {
        String? token =
            await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
        String? role =
            await SharedPrefHelper.getSecuredString(SharedPrefKeys.userRole);

        if (!mounted) return;

        if (token != null && token.isNotEmpty) {
          if (role == 'student') {
            context.go(AppRoute.home);
          } else {
            context.go(AppRoute.instructorCoursesManagement);
          }
        } else {
          context.go(AppRoute.onboarding);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 1500),
          opacity: 1.0,
          child: AnimatedScale(
            duration: const Duration(milliseconds: 2000),
            scale: 1.0,
            curve: Curves.elasticInOut,
            child: SvgPicture.asset(
              Assets.of(context).icons.app_icon_with_text_svg,
            ),
          ),
        ),
      ),
    );
  }
}
