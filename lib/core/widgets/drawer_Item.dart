import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masarat/core/helpers/constants.dart';
import 'package:masarat/core/theme/font_weight_helper.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/widgets/custom_text.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    required this.title,
    required this.onTap,
    super.key,
  });
  final String title;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(right: 24.w, top: 5.h),
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: SizedBox(
            height: 30.h,
            child: CustomText(
              textAlign: TextAlign.start,
              text: title,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 19.sp,
                fontWeight: FontWeightHelper.regular,
                fontFamily: Constants.fontName,
              ),
            ),
            // leading: Icon(icon,color: AppColors.drawerIconColor),
          ),
        ),
      ),
    );
  }
}
