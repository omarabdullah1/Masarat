import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
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
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        context.go(AppRoute.login);
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
