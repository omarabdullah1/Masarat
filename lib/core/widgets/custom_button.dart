import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masarat/core/helpers/constants.dart';
import 'package:masarat/core/theme/font_weight_helper.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.labelText,
    super.key,
    this.onTap,
    this.buttonColor,
    this.textColor,
    this.textFontSize,
    this.width,
    this.height,
    this.icon,
    this.labelText2,
    this.borderColor,
    this.borderWidth = 0,
    this.fontWeight,
    this.radius,
  });

  final void Function()? onTap;
  final String labelText;
  final String? labelText2;
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;
  final double? textFontSize;
  final double? width;
  final double? height;
  final double borderWidth;
  final IconData? icon;
  final double? radius;

  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    // Check if the button is disabled
    final bool isDisabled = onTap == null;

    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDisabled
            ? (buttonColor ?? AppColors.primary).withOpacity(0.7)
            : buttonColor ?? AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 14.r),
          side: BorderSide(
            color: isDisabled
                ? (borderColor ?? AppColors.primary).withOpacity(0.7)
                : borderColor ?? AppColors.primary,
            width: borderWidth,
          ),
        ),
        fixedSize: Size(width ?? 318.w, height ?? 57.h),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: CustomText(
              text: labelText,
              style: TextStyle(
                color: onTap == null
                    ? (textColor ?? Colors.white).withOpacity(0.7)
                    : textColor,
                fontSize: textFontSize,
                fontWeight: fontWeight ?? FontWeightHelper.bold,
                fontFamily: Constants.fontName,
              ),
            ),
          ),
          if (labelText2 != null) ...[
            CustomText(
              text: labelText2!,
              style: TextStyle(
                color: textColor,
                fontSize: textFontSize,
                fontWeight: fontWeight ?? FontWeight.w500,
                fontFamily: Constants.fontName,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
