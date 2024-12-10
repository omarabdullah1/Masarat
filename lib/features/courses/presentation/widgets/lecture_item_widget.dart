import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masarat/core/utils/app_colors.dart';

class LectureItemWidget extends StatelessWidget {
  final String lecture;
  final VoidCallback onDelete;

  const LectureItemWidget({
    Key? key,
    required this.lecture,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(

      shape: OutlineInputBorder(

        borderSide: BorderSide(color: AppColors.gery200),
        borderRadius: BorderRadius.circular(8.r)
      ),


      elevation: 0,
      color: AppColors.background,
      child: ListTile(
        title: Text(lecture),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
