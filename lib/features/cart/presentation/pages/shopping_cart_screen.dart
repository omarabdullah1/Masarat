import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masarat/core/theme/font_weight_helper.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/widgets/CustomDrawer.dart';
import 'package:masarat/core/widgets/CustomScaffold.dart';
import 'package:masarat/core/widgets/course_card_widget.dart';
import 'package:masarat/core/widgets/custom_text.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(

      haveAppBar: true,
      drawer: const CustomDrawer(),
      backgroundColorAppColor: AppColors.background,
      backgroundColor: AppColors.background,
      drawerIconColor: AppColors.primary,

      body: Column(
        children: [
          Center(
            child: CustomText(text: 'سلة المشتريات',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 22.sp,
                fontWeight: FontWeightHelper.regular,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding:   EdgeInsets.symmetric(vertical: 10.h),
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return CourseCard(
                    title: 'مهارات أخصائي محاسبة',
                    price: 'السعر : SAR 1200',
                    havePrice: true,
                    hours: '7 ساعات',
                    lectures: 'عدد المحاضرات: 42',
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          // Remove from Cart Logic
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.background,
                          side: const BorderSide(color: Colors.red),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        child: const Text(
                          'حذف من السلة',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Padding(
            padding:   EdgeInsets.all(16.0.r),
            child: ElevatedButton(
              onPressed: () {
                // Logic for payment
                print('Proceed to Payment');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                padding:   EdgeInsets.symmetric(vertical: 12.h),
              ),
              child:   Center(
                child: Text(
                  'ادفع الآن',
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
