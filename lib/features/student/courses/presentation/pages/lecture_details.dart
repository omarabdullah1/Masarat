import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/widgets/custom_scaffold.dart';
import 'package:masarat/core/widgets/custom_text.dart';
// Temporarily removed YouTube player due to compatibility issues
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LectureDetailsScreen extends StatefulWidget {
  const LectureDetailsScreen({required this.lectureId, super.key});
  final String lectureId;

  @override
  State<LectureDetailsScreen> createState() => _LectureDetailsScreenState();
}

class _LectureDetailsScreenState extends State<LectureDetailsScreen> {
  // Placeholder for video state
  String videoTitle = "Introduction to Accounting";
  String videoStatus = "Video player temporarily unavailable";

  @override
  void initState() {
    super.initState();
    // YouTube player initialization code was here
  }

  @override
  void dispose() {
    // YouTube player disposal code was here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      haveAppBar: true,
      backgroundColorAppColor: AppColors.background,
      backgroundColor: AppColors.background,
      drawerIconColor: AppColors.primary,
      title: 'المحاضرة الأولى: أساسيات المحاسبة',
      body: Column(
        children: [
          // Interactive placeholder for video player
          InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content:
                      Text('Video player will be available in future updates'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: Container(
              height: 220.h,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.video_library,
                        size: 50.sp,
                        color: Colors.white,
                      ),
                      SizedBox(height: 16.h),
                      CustomText(
                        text: videoTitle,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CustomText(
                        text: videoStatus,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 16.h,
                    right: 16.w,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withAlpha((0.7 * 255).toInt()),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today,
                              size: 14.sp, color: Colors.white),
                          SizedBox(width: 4.w),
                          CustomText(
                            text: 'Coming Soon',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Lecture Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'محتوى المحاضرة',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text100,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  CustomText(
                    text:
                        'تتناول هذه المحاضرة المفاهيم الأساسية للمحاسبة وتشمل:',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.text100,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  _buildListItem('مبادئ المحاسبة الأساسية'),
                  _buildListItem('أنواع الحسابات والدفاتر المحاسبية'),
                  _buildListItem('معادلة الميزانية العمومية'),
                  _buildListItem('مفهوم القيد المزدوج'),
                  SizedBox(height: 24.h),
                  CustomText(
                    text: 'المرفقات والموارد',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text100,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildAttachmentItem(
                      'ملخص المحاضرة (PDF)', Icons.picture_as_pdf),
                  _buildAttachmentItem('أوراق العمل (XLSX)', Icons.table_chart),
                  _buildAttachmentItem('تمارين تطبيقية', Icons.assignment),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.circle, size: 8.sp, color: AppColors.primary),
          SizedBox(width: 8.w),
          Expanded(
            child: CustomText(
              text: text,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.text100,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentItem(String title, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.05 * 255).toInt()),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 24.sp, color: AppColors.primary),
          SizedBox(width: 16.w),
          Expanded(
            child: CustomText(
              text: title,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.text100,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Icon(Icons.download, size: 20.sp, color: AppColors.gray),
        ],
      ),
    );
  }
}
