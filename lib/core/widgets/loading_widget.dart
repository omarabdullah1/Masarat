import 'package:custom_loading/custom_loading.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:masarat/core/utils/app_colors.dart';

import '../../assets/assets.dart';

class LoadingWidget extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;
  final Color backgroundColor;
  final bool loadingState;
  const LoadingWidget({
    super.key,
    required this.loadingState,
    this.height = 100,
    this.width = 100,
    this.borderRadius = 15,
    this.backgroundColor = AppColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      width: width.h,
      child: CustomLoadingScaffold(
        backgroundColor: AppColors.transparent,
        isLoading: loadingState,
        blurIntensity: 1.0,
        loaderWidget: Container(
          height: height.h,
          width: width.h,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
            // boxShadow: [
            //   BoxShadow(
            //     color: AppColors.black.withAlpha(25),
            //     spreadRadius: 1,
            //     blurRadius: 10,
            //     offset: const Offset(0, 0),
            //   ),
            // ],
          ),
          child: Center(
            child: DotLottieLoader.fromAsset(
              Assets.of(context).lottie.loading_lottie,
              frameBuilder: (BuildContext context, DotLottie? dotLottie) =>
                  dotLottie != null
                      ? Lottie.memory(
                          dotLottie.animations.values.first,
                          height: height.h * 0.8,
                          width: width.h * 0.8,
                          fit: BoxFit.contain,
                        )
                      : SizedBox(
                          height: 24.h,
                          width: 24.h,
                          child: const CircularProgressIndicator(),
                        ),
              errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) =>
                  SizedBox(
                height: 24.h,
                width: 24.h,
                child: const CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
