import 'package:flutter/material.dart';
import 'package:masarat/core/utils/app_colors.dart';

class AddLectureButtonWidget extends StatelessWidget {
  const AddLectureButtonWidget({
    required this.isAddingLecture,
    required this.toggleAddLecture,
    super.key,
  });
  final bool isAddingLecture;
  final VoidCallback toggleAddLecture;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: toggleAddLecture,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.white),
        foregroundColor: WidgetStateProperty.all(AppColors.primary),
        elevation: WidgetStateProperty.all(0),
        side:
            WidgetStateProperty.all(const BorderSide(color: AppColors.primary)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        ),
      ),
      icon: Icon(isAddingLecture ? Icons.close : Icons.add),
      label: Text(
        isAddingLecture ? 'إلغاء' : 'إضافة محاضرة جديدة',
      ),
    );
  }
}
