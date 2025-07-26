import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/features/instructor/logic/update_course/update_course_cubit.dart';
import 'package:masarat/features/instructor/logic/update_course/update_course_state.dart';

class UpdateCourseBlocListener extends StatelessWidget {
  const UpdateCourseBlocListener({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateCourseCubit, UpdateCourseState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          loadingCategories: () {},
          categoriesLoaded: (categories) {},
          categoriesError: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('فشل في تحميل الفئات: $error'),
                backgroundColor: AppColors.red,
                duration: const Duration(seconds: 4),
              ),
            );
          },
          updating: () {},
          updateSuccess: (course) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم تحديث الدورة بنجاح'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 3),
              ),
            );
            Navigator.of(context).pop(course); // Return the updated course
          },
          updateError: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('فشل في تحديث الدورة: $error'),
                backgroundColor: AppColors.red,
                duration: const Duration(seconds: 4),
              ),
            );
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
