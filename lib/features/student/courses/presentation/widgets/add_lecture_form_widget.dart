import 'package:flutter/material.dart';
import 'package:masarat/core/utils/app_colors.dart';

class AddLectureFormWidget extends StatelessWidget {
  const AddLectureFormWidget({
    required this.courseNameController,
    required this.orderController,
    required this.addLecture,
    required this.onPickVideo,
    required this.onPickResources,
    required this.isPreviewable,
    required this.onPreviewableChanged,
    this.selectedVideoName,
    this.selectedResourceNames = const [],
    super.key,
  });
  final TextEditingController courseNameController;
  final TextEditingController orderController;
  final VoidCallback addLecture;
  final VoidCallback onPickVideo;
  final VoidCallback onPickResources;
  final String? selectedVideoName;
  final List<String> selectedResourceNames;
  final bool isPreviewable;
  final ValueChanged<bool> onPreviewableChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.greyLight200, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: courseNameController,
              decoration: const InputDecoration(
                labelText: 'عنوان الدرس',
                iconColor: AppColors.primary,
                fillColor: AppColors.white,
                labelStyle: TextStyle(color: AppColors.gray),
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Order field
            TextField(
              controller: orderController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'ترتيب الدرس',
                iconColor: AppColors.primary,
                fillColor: AppColors.white,
                labelStyle: TextStyle(color: AppColors.gray),
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Is Previewable switch
            Row(
              children: [
                Switch(
                  value: isPreviewable,
                  onChanged: onPreviewableChanged,
                  activeColor: AppColors.primary,
                ),
                const SizedBox(width: 8),
                const Text('متاح للمعاينة',
                    style: TextStyle(fontSize: 14, color: AppColors.gray)),
              ],
            ),
            const SizedBox(height: 16),
            // Video file picker
            Row(
              children: [
                Expanded(
                  child: Text(
                    selectedVideoName != null && selectedVideoName!.isNotEmpty
                        ? 'ملف الفيديو: $selectedVideoName'
                        : 'لم يتم اختيار ملف فيديو',
                    style: const TextStyle(fontSize: 14, color: AppColors.gray),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.video_file, color: AppColors.primary),
                  onPressed: onPickVideo,
                  tooltip: 'اختر ملف فيديو',
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Resources file picker
            Row(
              children: [
                Expanded(
                  child: Text(
                    selectedResourceNames.isNotEmpty
                        ? 'ملفات الموارد: ${selectedResourceNames.join(", ")}'
                        : 'لم يتم اختيار ملفات موارد',
                    style: const TextStyle(fontSize: 14, color: AppColors.gray),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.attach_file, color: AppColors.primary),
                  onPressed: onPickResources,
                  tooltip: 'اختر ملفات موارد',
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: addLecture,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                ),
                child: const Text('إضافة الدرس'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
