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
import 'package:masarat/features/student/cart/logic/student_cart/student_cart_cubit.dart';
import 'package:masarat/features/student/courses/data/models/course_model.dart';
import 'package:masarat/features/student/courses/services/course_state_service.dart';

class CourseDetailsScreen extends StatelessWidget {
  CourseDetailsScreen({
    required this.course,
    super.key,
  });
  final CourseModel course;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // Store the current course in our service for persistence
    getIt<CourseStateService>().selectedCourse = course;
    return CustomScaffold(
      key: scaffoldKey,
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
                child: const Center(
                  child: Icon(Icons.error, color: Colors.red),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Course Details
  Widget _buildCourseDetails(CourseModel course) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: course.title,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeightHelper.semiBold,
            color: AppColors.primary,
          ),
        ),
        Gap(8.h),
        Row(
          children: [
            const Icon(
              Icons.access_time,
              color: AppColors.gray,
              size: 16,
            ),
            Gap(4.w),
            CustomText(
              text: '${course.durationEstimate} ساعات',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.gray,
              ),
            ),
            Gap(16.w),
            const Icon(
              Icons.video_library,
              color: AppColors.gray,
              size: 16,
            ),
            Gap(4.w),
            CustomText(
              text: '${course.lessons.length} محاضرة',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.gray,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Section Title
  Widget _buildSectionTitle(String title) {
    return CustomText(
      text: title,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeightHelper.semiBold,
        color: AppColors.primary,
      ),
    );
  }

  // Course Description
  Widget _buildCourseDescription(String description) {
    return CustomText(
      text: description,
      style: TextStyle(
        fontSize: 14.sp,
        color: Colors.black87,
        height: 1.5,
      ),
    );
  }

  // Action Buttons
  Widget _buildActionButtons(int price) {
    final cartCubit = getIt<StudentCartCubit>();

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
            onTap: () {
              // Navigate to the checkout screen or purchase flow
              // For now, we'll just add to cart
              _addToCart(cartCubit);
            },
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
            onTap: () {
              _addToCart(cartCubit);
            },
            textFontSize: 10.sp,
            borderColor: AppColors.red,
            fontWeight: FontWeightHelper.light,
          ),
        ),
      ],
    );
  }

  // Add to Cart Helper Method
  void _addToCart(StudentCartCubit cartCubit) {
    // Get the current context from the scaffold key
    final BuildContext context = scaffoldKey.currentContext!;

    // Show loading indicator
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('جاري إضافة الدورة إلى السلة...'),
        duration: Duration(seconds: 1),
      ),
    );

    // Add to cart via cubit
    cartCubit.addToCart(course.id).then((success) {
      // Check current state after operation completes
      String? errorMessage;
      bool isErrorState = false;

      cartCubit.state.maybeWhen(
        error: (message) {
          errorMessage = message;
          isErrorState = true;
        },
        orElse: () {},
      );

      if (isErrorState && errorMessage != null) {
        // Check if it's an "already in cart" type of message
        // We've already checked that errorMessage is not null
        final String nonNullMessage = errorMessage!; // Use non-null assertion
        final isAlreadyInCartMessage =
            nonNullMessage.contains('موجودة بالفعل') ||
                nonNullMessage.contains('already in') ||
                nonNullMessage.toLowerCase().contains('already in your cart');

        // Show the specific error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(nonNullMessage),
            backgroundColor: isAlreadyInCartMessage || success
                ? Colors.orange // Orange for "already in cart" warnings
                : Colors.red, // Red for actual errors
          ),
        );
      } else if (success) {
        // Normal success case
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تمت إضافة الدورة إلى السلة بنجاح'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Generic failure case (shouldn't reach here if errors are properly handled)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('فشل في إضافة الدورة إلى السلة'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
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

        // Navigate to the lessons screen
        context.goNamed(
          AppRoute.lectureScreen,
          pathParameters: {'courseid': courseId},
          extra: course, // Pass the entire course object
        );
      },
      textFontSize: 16.sp,
      borderColor: AppColors.gray,
      fontWeight: FontWeightHelper.light,
    );
  }

  // Comments Section - currently unused
}

extension BuildContextExtension on BuildContext? {
  void let(Function(BuildContext context) block) {
    if (this != null) {
      block(this!);
    }
  }
}
