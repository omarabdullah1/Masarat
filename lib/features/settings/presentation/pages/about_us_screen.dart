import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masarat/core/theme/font_weight_helper.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/widgets/CustomDrawer.dart';
import 'package:masarat/core/widgets/CustomScaffold.dart';
import 'package:masarat/core/widgets/custom_text.dart';

class  AboutUsScreen extends StatelessWidget {
  const  AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final aboutUs = <String>[
      'من نحن',
      'المدربين',
      'فريق العمل',
      'معرض الصور',
    ];
    return CustomScaffold(
      backgroundColorAppColor: AppColors.background,
      backgroundColor: AppColors.background,
      drawerIconColor: AppColors.primary,
      haveAppBar: true,
      drawer: const CustomDrawer(),

      body: Padding(
        padding:   EdgeInsets.all(16.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Icon
            Center(
              child: CustomText(
                text: 'من نحن',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 22.sp,
                  fontWeight: FontWeightHelper.regular,
                ),
              ),
            ),

            SizedBox(height: 15.h),
            // List of policies
            Expanded(
              child: ListView(
                children: aboutUs.map((info) {
                  return ListTile(

                    leading: CustomText(
                      text:info,
                      textAlign: TextAlign.right,
                      style:   TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black87,
                      ),
                    ),
                    onTap: () {
                      // Handle navigation or logic for each policy
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}