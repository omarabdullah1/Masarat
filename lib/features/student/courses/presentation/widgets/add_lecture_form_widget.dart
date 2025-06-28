import 'package:flutter/material.dart';
import 'package:masarat/core/utils/app_colors.dart';

class AddLectureFormWidget extends StatelessWidget {
  const AddLectureFormWidget({
    required this.courseNameController,
    required this.contentController,
    required this.sourceController,
    required this.addLecture,
    super.key,
    this.orderController,
    this.durationController,
  });
  final TextEditingController courseNameController;
  final TextEditingController contentController;
  final TextEditingController sourceController;
  final TextEditingController? orderController;
  final TextEditingController? durationController;
  final VoidCallback addLecture;

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
            TextField(
              controller: contentController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'رابط المحتوى (فيديو/صوت)',
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
            if (orderController != null)
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
            if (orderController != null) const SizedBox(height: 16),
            if (durationController != null)
              TextField(
                controller: durationController,
                decoration: const InputDecoration(
                  labelText: 'مدة الدرس المقدرة (مثال: 10 دقائق)',
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
            if (durationController != null) const SizedBox(height: 16),
            TextField(
              controller: sourceController,
              decoration: InputDecoration(
                labelText: 'مصادر إضافية (اختياري)',
                iconColor: AppColors.primary,
                fillColor: AppColors.white,
                labelStyle: const TextStyle(color: AppColors.gray),
                filled: true,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.upload, color: AppColors.primary),
                  onPressed: () {},
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                border: const OutlineInputBorder(),
              ),
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
