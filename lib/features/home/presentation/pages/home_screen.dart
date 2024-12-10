import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:masarat/config/app_route.dart';
import 'package:masarat/config/app_router.dart';
import 'package:masarat/core/theme/font_weight_helper.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/utils/assets_mangment.dart';
import 'package:masarat/core/widgets/CustomDrawer.dart';
import 'package:masarat/core/widgets/CustomScaffold.dart';
import 'package:masarat/core/widgets/custom_button.dart';
import 'package:masarat/core/widgets/custom_text.dart';
import 'package:masarat/features/home/presentation/pages/my_library.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        haveAppBar: true,
        title: '',
        backgroundColorAppColor: AppColors.background,
        backgroundColor:  AppColors. background,
        drawerIconColor: AppColors.primary,
        drawer: const CustomDrawer(),
        body: Column(children: [
          // Welcome Text
            CustomText(
           text:   'أهلاً بك في',
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeightHelper.light,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          // Main Title
            CustomText(
         text:    'المسارات الاحترافية',
            style: TextStyle(
              fontSize: 32.sp,
              fontWeight: FontWeightHelper.semiBold,
              color:AppColors.primary,
        
            ),
            textAlign: TextAlign.center,
          ),
         
              CustomText(
         text:'للتدريب والتسويق',
            style: TextStyle(
              fontSize: 21.sp,
              fontWeight: FontWeightHelper.light,
              color:AppColors.orange,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
            Gap( 20.h),
        
            Image.asset(
           AppImage.slideImage,  
            height: 250.h,
          ),
            Gap( 20.h),
          // Description Text
            Text(
              'نحن نمهد الطريق لشغفك وإبداعك حتى تستطيع السير بخطوات واثقة لإبراز قدراتك ومواهبك للجميع متجاوزاً كل الحواجز والعقبات للوصول إلى هدفك.',
            style: TextStyle(
              fontSize: 15.sp,
              color: AppColors.gray,
              fontWeight: FontWeightHelper.  light
               
            ),
            textAlign: TextAlign.center,
          ),
            Gap( 20.h),
          // Dots Indicator
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(radius: 5, backgroundColor: Colors.grey[300]),
              const SizedBox(width: 5),
              CircleAvatar(radius: 5, backgroundColor: Colors.grey[700]),
              const SizedBox(width: 5),
              CircleAvatar(radius: 5, backgroundColor: Colors.grey[300]),
            ],
          ),
          const SizedBox(height: 30),
          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Training Courses Button
              Expanded(
                child: CustomButton(
                  height: 42.h,
                  radius: 12.r,
                  labelText: 'الدورات التدريبية',
                  buttonColor: AppColors.withe,
                  borderColor: AppColors.gray,
                  textColor: AppColors.gray,
                 fontWeight:FontWeightHelper.light,
                  onTap: () {

                    context.goNamed(AppRoute.trainingCourses);
                  },
                  textFontSize: 14.sp,
                ),
              ),
              Gap(15.w),
              // My Office Button
              Expanded(
                child: CustomButton(
                  height: 42.h,
                  labelText: 'مكتــــــــــــبتي',
                  radius: 12.r,
                  buttonColor: AppColors.withe,
                  textColor: AppColors.primary,
                  onTap: () {
                 context.go('/home/myLibrary');
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => MyLibrary(),))
                  },
                  textFontSize: 14.sp,
                  fontWeight:FontWeightHelper.light,
                ),
              ),
            ],
          ),
        ],),);
  }
}
