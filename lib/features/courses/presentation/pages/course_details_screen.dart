import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:masarat/config/app_route.dart';
import 'package:masarat/core/theme/font_weight_helper.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/widgets/custom_button.dart';
import 'package:masarat/core/widgets/custom_drawer.dart';
import 'package:masarat/core/widgets/custom_scaffold.dart';
import 'package:masarat/core/widgets/custom_text.dart';

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen({
    required this.courseId,
    super.key,
  });
  final String courseId;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      haveAppBar: true,
      backgroundColorAppColor: AppColors.background,
      backgroundColor: AppColors.background,
      drawerIconColor: AppColors.primary,
      drawer: const CustomDrawer(),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_forward_ios_outlined,
            color: AppColors.primary,
          ),
        ),
      ],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCourseImage(),
              Gap(20.h),
              _buildCourseDetails(),
              Gap(15.h),
              _buildSectionTitle('عن الدورة'),
              Gap(10.h),
              _buildCourseDescription(),
              Gap(20.h),
              _buildSectionTitle('تعليقات المتدربين'),
              Gap(10.h),
              _buildCommentsSection(),
              Gap(20.h),
              _buildActionButtons(),
              Gap(15.h),
              _buildWatchButton(context),
              Gap(20.h),
            ],
          ),
        ),
      ),
    );
  }

  // Course Image
  Widget _buildCourseImage() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(11.0.r),
        child: Image.network(
          'https://images.pexels.com/photos/29090307/pexels-photo-29090307/free-photo-of-cyclist-riding-past-parisian-building-facade.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
          height: 200.h,
          width: 290.w,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Course Details Section
  Widget _buildCourseDetails() {
    return Column(
      children: [
        Center(
          child: CustomText(
            text: 'مهارات أخصائي محاسبة',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Gap(8.h),
        Center(
          child: CustomText(
            text: 'SAR 1200',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
        ),
        Gap(8.h),
        _buildTrainerInfo('اسم المدرب: مصطفى محمد'),
        _buildTrainerInfo('عدد الساعات: 7 ساعات'),
        _buildTrainerInfo('عدد المحاضرات: 42'),
      ],
    );
  }

  Widget _buildTrainerInfo(String text) {
    return Center(
      child: CustomText(
        text: text,
        style: TextStyle(
          fontSize: 12.sp,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  // Section Title
  Widget _buildSectionTitle(String title) {
    return CustomText(
      text: title,
      style: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeightHelper.regular,
        color: Colors.black,
      ),
    );
  }

  // Course Description
  Widget _buildCourseDescription() {
    return Text(
      'تهدف دورة تنمية مهارات أخصائي المحاسبة المالية إلى تحسين وتطوير مهارات '
      'المحاسبين العاملين في مجال المحاسبة والمال. وتشمل محاور الدورة موضوعات '
      'مثل المحاسبة الإدارية والمحاسبة المالية '
      'والتحليل المالي والتقارير المالية والقوانين ذات العلاقة بالمجال.',
      style: TextStyle(
        fontSize: 9.5.sp,
        color: Colors.grey[700],
        height: 1.5,
      ),
    );
  }

  // Comments Section
  Widget _buildCommentsSection() {
    return SizedBox(
      height: 100.h,
      child: ListView.separated(
        separatorBuilder: (context, index) => Gap(10.h),
        itemCount: 2,
        itemBuilder: (context, index) => _buildComment(),
      ),
    );
  }

  Widget _buildComment() {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lighterGray),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 15.r,
            backgroundColor: Colors.teal,
            child: const Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'فاطمة علي',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeightHelper.regular,
                    color: Colors.black,
                  ),
                ),
                Gap(5.h),
                Text(
                  'في عام 94% استفدت بشكل استثنائي في المجال المحاسبي تحت مسمى '
                  'مصنف المحاسبة المالية تعلمت كل من الخطط.',
                  style: TextStyle(
                    fontSize: 9.sp,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Action Buttons
  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: CustomButton(
            height: 27.h,
            radius: 58.r,
            labelText: 'شــراء الأن',
            buttonColor: AppColors.primary,
            textColor: AppColors.white,
            onTap: () {},
            textFontSize: 10.sp,
            fontWeight: FontWeightHelper.light,
          ),
        ),
        Gap(8.w),
        Expanded(
          flex: 2,
          child: CustomButton(
            height: 27.h,
            radius: 58.r,
            labelText: 'إضافة إلى السلة',
            buttonColor: AppColors.background,
            textColor: AppColors.red,
            onTap: () {},
            textFontSize: 10.sp,
            borderColor: AppColors.red,
            fontWeight: FontWeightHelper.light,
          ),
        ),
      ],
    );
  }

  // Watch Button
  Widget _buildWatchButton(BuildContext context) {
    return CustomButton(
      height: 36.h,
      width: double.infinity,
      radius: 58.r,
      labelText: 'مشاهدة أول محاضرة مجاناً',
      buttonColor: AppColors.background,
      textColor: AppColors.gray,
      onTap: () {
        context.goNamed(
          AppRoute.lectureScreen,
          pathParameters: {'courseId': '554'},
        );
      },
      textFontSize: 10.sp,
      fontWeight: FontWeightHelper.light,
    );
  }
}
