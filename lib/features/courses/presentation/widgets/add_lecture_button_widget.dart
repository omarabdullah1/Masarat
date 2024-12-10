import 'package:flutter/material.dart';
import 'package:masarat/core/utils/app_colors.dart';

class AddLectureButtonWidget extends StatelessWidget {

  const AddLectureButtonWidget({
    super.key,
    required this.isAddingLecture,
    required this.toggleAddLecture,
  });
  final bool isAddingLecture;
  final VoidCallback toggleAddLecture;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: toggleAddLecture,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.withe),
        foregroundColor: MaterialStateProperty.all(AppColors.primary),
        elevation: MaterialStateProperty.all(0),
        side: MaterialStateProperty.all(BorderSide(color: AppColors.primary)),
        shape: MaterialStateProperty.all(
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
