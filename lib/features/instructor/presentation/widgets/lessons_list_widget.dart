import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/widgets/custom_text.dart';
import 'package:masarat/features/instructor/data/models/lesson/lesson_model.dart';
import 'package:masarat/features/instructor/presentation/widgets/lesson_item_widget.dart';

class LessonsListWidget extends StatelessWidget {
  const LessonsListWidget({
    required this.lessons,
    required this.onDeleteLesson,
    required this.onEditLesson,
    required this.onUploadVideo,
    super.key,
  });
  final List<LessonModel> lessons;
  final void Function(LessonModel lesson) onDeleteLesson;
  final void Function(LessonModel lesson) onEditLesson;
  final void Function(LessonModel lesson) onUploadVideo;

  @override
  Widget build(BuildContext context) {
    if (lessons.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school_outlined,
              size: 64.sp,
              color: AppColors.gray.withValues(alpha: 0.5 * 255),
            ),
            SizedBox(height: 16.h),
            CustomText(
              text: 'لا توجد دروس في هذه الدورة بعد',
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.gray,
              ),
            ),
            SizedBox(height: 8.h),
            CustomText(
              text: 'اضغط على "إضافة محاضرة جديدة" لإضافة الدرس الأول',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.gray.withValues(alpha: 0.7 * 255),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: CustomText(
            text: 'الدروس (${lessons.length})',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
        // Use Column instead of Flexible with ListView for better integration with parent ScrollView
        Column(
          children: lessons.map((lesson) {
            return LessonItemWidget(
              lesson: lesson,
              onDelete: () => onDeleteLesson(lesson),
              onEdit: () => onEditLesson(lesson),
              onUploadVideo: () => onUploadVideo(lesson),
            );
          }).toList(),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
