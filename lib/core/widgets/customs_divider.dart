import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masarat/core/utils/app_colors.dart';

class CustomsDivider extends StatelessWidget {
  const CustomsDivider({super.key, this.width, this.height, this.color});
  final double? width;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? AppColors.hint,
        borderRadius: BorderRadius.circular(12.r),
      ),
      width: width,
      height: height,
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
    );
  }
}
