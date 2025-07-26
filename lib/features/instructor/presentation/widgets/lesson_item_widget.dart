import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/widgets/custom_text.dart';
import 'package:masarat/features/instructor/data/models/lesson/lesson_model.dart';

class LessonItemWidget extends StatelessWidget {
  const LessonItemWidget({
    required this.lesson,
    required this.onDelete,
    required this.onEdit,
    required this.onUploadVideo,
    super.key,
  });
  final LessonModel lesson;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onUploadVideo;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: const BorderSide(color: AppColors.greyLight200, width: 1),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row with title and order
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomText(
                    text: lesson.title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1 * 255),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: CustomText(
                        text: 'ترتيب: ${lesson.order}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Gap(8.w),
                    IconButton(
                      icon: const Icon(Icons.videocam, color: Colors.green),
                      onPressed: onUploadVideo,
                      tooltip: 'رفع فيديو',
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: onEdit,
                      tooltip: 'تعديل الدرس',
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: onDelete,
                      tooltip: 'حذف الدرس',
                    ),
                  ],
                ),
              ],
            ),
            Gap(8.h),

            // Content type and duration
            Row(
              children: [
                Icon(
                  lesson.contentType == 'video'
                      ? Icons.play_circle
                      : Icons.article,
                  color: AppColors.gray,
                  size: 16.sp,
                ),
                Gap(4.w),
                CustomText(
                  text: lesson.contentType == 'video' ? 'فيديو' : 'نص',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.gray,
                  ),
                ),
                Gap(16.w),
                Icon(
                  Icons.schedule,
                  color: AppColors.gray,
                  size: 16.sp,
                ),
                Gap(4.w),
                CustomText(
                  text: 'المدة: ${lesson.durationEstimate}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.gray,
                  ),
                ),
              ],
            ),
            Gap(8.h),

            // Content preview
            CustomText(
              text: lesson.content,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.gray,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Gap(8.h),

            // Preview badge
            if (lesson.isPreviewable)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1 * 255),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: CustomText(
                  text: 'متاح للمعاينة',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
