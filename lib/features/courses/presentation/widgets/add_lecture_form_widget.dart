import 'package:flutter/material.dart';
import 'package:masarat/core/utils/app_colors.dart';

class AddLectureFormWidget extends StatelessWidget {
  const AddLectureFormWidget({
    required this.courseNameController,
    required this.contentController,
    required this.sourceController,
    required this.addLecture,
    super.key,
  });
  final TextEditingController courseNameController;
  final TextEditingController contentController;
  final TextEditingController sourceController;
  final VoidCallback addLecture;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: courseNameController,
            decoration: InputDecoration(
              labelText: 'اسم الدورة التدريبية',
              iconColor: AppColors.primary,
              fillColor: AppColors.withe,
              labelStyle: TextStyle(color: AppColors.gray),
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary),
              ),
              enabledBorder: const OutlineInputBorder(
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
            decoration: InputDecoration(
              labelText: 'وضع محتوى المحاضرة',
              iconColor: AppColors.primary,
              fillColor: AppColors.withe,
              labelStyle: TextStyle(color: AppColors.gray),
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: sourceController,
            decoration: InputDecoration(
              labelText: 'وضع المصادر',
              iconColor: AppColors.primary,
              fillColor: AppColors.withe,
              labelStyle: TextStyle(color: AppColors.gray),
              filled: true,
              suffixIcon: IconButton(
                icon: Icon(Icons.upload, color: AppColors.primary),
                onPressed: () {},
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary),
              ),
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: addLecture,
              child: const Text('رفع المحاضرة'),
            ),
          ),
        ],
      ),
    );
  }
}
