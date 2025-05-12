import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masarat/core/theme/font_weight_helper.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/widgets/custom_drawer.dart';
import 'package:masarat/core/widgets/custom_scaffold.dart';
import 'package:masarat/core/widgets/custom_text.dart';

class PoliciesScreen extends StatelessWidget {
  const PoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final policies = <String>[
      'سياسة الخصوصية',
      'أداء قياس رضا المستفيدين',
      'سياسة الحضور',
      'حقوق الملكية الفكرية وحقوق النشر',
      'النزاهة الأكاديمية',
      'خطة التدريب الخاصة بالمدربين',
      'الدليل الإرشادي للمدرب',
      'الدليل الإرشادي للمتدرب',
      'أداء قياس رضا المستفيدين',
      'الدليل الإرشادي لاستخدام ZOOM',
      'سياسة اللقاء والاسترجاع',
      'الدلة الإرشادية والدعم والتدريب',
    ];
    return CustomScaffold(
      backgroundColorAppColor: AppColors.background,
      backgroundColor: AppColors.background,
      drawerIconColor: AppColors.primary,
      haveAppBar: true,
      drawer: const CustomDrawer(),
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: Column(
          children: [
            CustomText(
              text: 'سياسات التطبيق',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 22.sp,
                fontWeight: FontWeightHelper.regular,
              ),
            ),

            SizedBox(height: 15.h),
            // List of policies
            Expanded(
              child: ListView(
                children: policies.map((policy) {
                  return ListTile(
                    title: Text(
                      policy,
                      textAlign: TextAlign.right,
                      style: TextStyle(
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
