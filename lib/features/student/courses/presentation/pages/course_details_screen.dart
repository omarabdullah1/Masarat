import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:masarat/config/app_route.dart';
import 'package:masarat/core/di/dependency_injection.dart';
import 'package:masarat/core/theme/font_weight_helper.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/utils/image_url_helper.dart';
import 'package:masarat/core/widgets/custom_button.dart';
import 'package:masarat/core/widgets/custom_drawer.dart';
import 'package:masarat/core/widgets/custom_scaffold.dart';
import 'package:masarat/core/widgets/custom_text.dart';
import 'package:masarat/features/student/courses/data/models/course_model.dart';
import 'package:masarat/features/student/courses/services/course_state_service.dart';

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen({
    required this.course,
    super.key,
  });
  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    // Store the current course in our service for persistence
    getIt<CourseStateService>().selectedCourse = course;
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
          icon: const Icon(
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
              _buildCourseImage(course.coverImageUrl),
              Gap(20.h),
              _buildCourseDetails(course),
              Gap(15.h),
              _buildSectionTitle('عن الدورة'),
              Gap(10.h),
              _buildCourseDescription(course.description),
              Gap(20.h),
              // _buildSectionTitle('تعليقات المتدربين'),
              // Gap(10.h),
              // _buildCommentsSection(),
              Gap(20.h),
              _buildActionButtons(course.price),
              Gap(15.h),
              _buildWatchButton(context, course.id),
              Gap(20.h),
            ],
          ),
        ),
      ),
    );
  }

  // Course Image
  Widget _buildCourseImage(String imageUrl) {
    // Format the image URL properly using our helper
    final fullImageUrl = ImageUrlHelper.formatImageUrl(imageUrl);

    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(11.0.r),
        child: CachedNetworkImage(
          imageUrl: fullImageUrl,
          height: 200.h,
          width: 290.w,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            height: 200.h,
            width: 290.w,
            color: Colors.grey[300],
            child: const Center(child: CircularProgressIndicator()),
          ),
          errorWidget: (context, url, error) {
            // Fallback image in case of error
            return CachedNetworkImage(
              imageUrl: ImageUrlHelper.defaultCourseImage,
              height: 200.h,
              width: 290.w,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Container(
                height: 200.h,
                width: 290.w,
                color: Colors.grey[300],
                child: const Icon(Icons.error_outline,
                    size: 40, color: Colors.red),
              ),
            );
          },
        ),
      ),
    );
  }

  // Course Details Section
  Widget _buildCourseDetails(CourseModel course) {
    return Column(
      children: [
        Center(
          child: CustomText(
            text: course.title,
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
            text: 'SAR ${course.price}',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
        ),
        Gap(8.h),
        _buildTrainerInfo('اسم المدرب: ${course.instructor.fullName}'),
        _buildTrainerInfo('عدد الساعات: ${course.durationEstimate}'),
        _buildTrainerInfo('عدد المحاضرات: ${course.lessons.length}'),
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
  Widget _buildCourseDescription(String description) {
    return Text(
      description,
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
  Widget _buildActionButtons(int price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: CustomButton(
            height: 27.h,
            radius: 58.r,
            labelText: 'شــراء الأن - SAR $price',
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
  Widget _buildWatchButton(BuildContext context, String courseId) {
    // We'll fetch up-to-date lessons from the API in the lectures list screen

    return CustomButton(
      height: 36.h,
      width: double.infinity,
      radius: 58.r,
      labelText: 'مشاهدة أول محاضرة مجاناً',
      buttonColor: AppColors.background,
      textColor: AppColors.gray,
      onTap: () {
        // Store the course in our service for persistence between screens
        getIt<CourseStateService>().selectedCourse = course;

        // Navigate to lectures list screen which will show all lessons
        // The screen will fetch up-to-date lessons from the API
        context.goNamed(
          AppRoute.lectureScreen,
          pathParameters: {'courseid': courseId},
        );
      },
      textFontSize: 10.sp,
      fontWeight: FontWeightHelper.light,
    );
  }
}
