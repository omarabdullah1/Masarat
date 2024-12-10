import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:masarat/core/theme/font_weight_helper.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/utils/assets_mangment.dart';
import 'package:masarat/core/widgets/CustomDrawer.dart';
import 'package:masarat/core/widgets/CustomScaffold.dart';
import 'package:masarat/core/widgets/custom_button.dart';

import '../../../../core/widgets/custom_text.dart';

class  PricingScreen extends StatelessWidget {
  const PricingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      haveAppBar: true,
      backgroundColorAppColor: AppColors.background,
      backgroundColor: AppColors.background,
      drawerIconColor: AppColors.primary,
      drawer: const CustomDrawer(),
      body:   SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: CustomText(
                text: 'الإرشاد المهني',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 22.sp,
                  fontWeight: FontWeightHelper.regular,
                ),
              ),
            ),
            Gap(16.h),
            Text(
              'باقات مبتدئ الخبرة',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Gap( 8.h),
            Text(
              'هذه الباقات مخصصة للخبرة التي تتراوح بين سنة كحد أدنى إلى خمس سنوات خبرة',
              style: TextStyle(fontSize: 12.sp,color:AppColors.gray),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            const PackageCard(
              price: '530',
              benefits: [
                'عمل سيرة ذاتية احترافية',
                'عمل صفحة لينكدإن احترافية',
                'إرسال إلى أكثر من 800 جهة و شركة سعودية',
              ],
            ),
            SizedBox(height: 20.h),
            const PackageCard(
              price: '1200',
              benefits: [
                'التواصل مع المشترك لإبراز نقاط القوة',
                'التدريب على المقابلات الوظيفية',
                'عمل سيرة ذاتية احترافية',
                'عمل صفحة لينكدإن احترافية',
                'التدريب على كيفية التسويق من خلال برنامج لينكدإن',
                'إرسال السيرة الذاتية إلى 4000 جهة و شركة سعودية بالإضافة إلى مكاتب التوظيف',
              ],
            ),
            SizedBox(height: 20.h),
            const PackageCard(
              price: '900',
              benefits: [
                'التواصل مع المشترك لمعرفة المسار المهني المستهدف',
                'عمل سيرة ذاتية احترافية',
                'عمل صفحة لينكدإن احترافية',
                'إرسال السيرة الذاتية إلى 4000 جهة و شركة سعودية بالإضافة إلى مكاتب التوظيف',
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PackageCard extends StatelessWidget {
  final String price;
  final List<String> benefits;

  const PackageCard({super.key,
    required this.price,
    required this.benefits,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(

      children: [


        Badge(
          padding: const EdgeInsets.symmetric(horizontal: 20),

          alignment:  Alignment .   topCenter,
          backgroundColor:Colors.orange ,
          offset: Offset(-55.w, -5) ,

          label:Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'الأكثر مبيعاً',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ) ,
          child: Container(

            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.lighterGray)),
            child: Padding(
              padding:   EdgeInsets.all(16.0.r),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: SvgPicture.asset( AppImage.twoStar  )),
                    Text(
                      'باقة سيرة ذاتية وصفحة لينكدإن - مبتدئ الخبرة',

                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                      textDirection: TextDirection.rtl,


                    ),
                    Gap(2.h),
                    Divider(
                      height: 2.h,
                      color: AppColors.lighterGray,
                      endIndent: 57,
                    ),
                    SizedBox(height: 8.h),
                  Text.rich(
                    TextSpan(
                      text: price,
                      style:   TextStyle(fontSize: 28.sp, color: AppColors.primary, fontWeight: FontWeight.bold),
                      children: [
                          TextSpan(
                          text: ' ريال',
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal,color: Colors.black),
                        ),
                      ],
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  Gap(2.h),
                  Divider(
                    height: 2.h,
                    color: AppColors.lighterGray,
                    endIndent: 57,
                  ),
                    SizedBox(height: 3.h),
                  ...benefits.map(
                        (benefit) => Row(
                      textDirection: TextDirection.rtl,
                      children: [
                          Icon(Icons.check, color: AppColors.primary, size: 20.sp),
                          SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            benefit,
                            textDirection: TextDirection.rtl,
                            style:   TextStyle(fontSize: 12.sp, color: AppColors.gray),
                          ),
                        ),
                      ],
                    ),
                  ),
                    SizedBox(height: 20.h),

                  CustomButton(
                    height: 27.h,
                    radius: 58.r,
                    labelText: 'اشترك الآن',
                    buttonColor: AppColors.withe,
                    textColor: AppColors.primary,
                    borderColor:AppColors.primary ,
                    onTap: () {},
                    textFontSize: 14.sp,
                    fontWeight:FontWeightHelper.light,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}