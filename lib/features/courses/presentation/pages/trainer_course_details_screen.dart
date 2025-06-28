import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:masarat/core/theme/font_weight_helper.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/widgets/custom_scaffold.dart';
import 'package:masarat/core/widgets/custom_text.dart';
import 'package:masarat/features/courses/presentation/widgets/add_lecture_button_widget.dart';
import 'package:masarat/features/courses/presentation/widgets/add_lecture_form_widget.dart';
import 'package:masarat/features/courses/presentation/widgets/lecture_list_widget.dart';

class TrainerCourseDetailsScreen extends StatefulWidget {
  const TrainerCourseDetailsScreen({required this.courseId, super.key});
  final String courseId;

  @override
  State<TrainerCourseDetailsScreen> createState() =>
      _TrainerCourseDetailsScreenState();
}

class _TrainerCourseDetailsScreenState
    extends State<TrainerCourseDetailsScreen> {
  // State variables
  bool isAddingLecture = false;
  // Controls visibility of the "Add Lecture" widget
  final List<String> lectures = [];
  // Holds the list of lectures
  final TextEditingController courseNameController = TextEditingController();

  final TextEditingController contentController = TextEditingController();

  final TextEditingController sourceController = TextEditingController();

  void addLecture() {
    // Validate and add lecture
    if (courseNameController.text.isNotEmpty &&
        contentController.text.isNotEmpty) {
      setState(() {
        lectures.add(courseNameController.text);
        isAddingLecture = false; // Hide the "Add Lecture" widget
      });
      courseNameController.clear();
      contentController.clear();
      sourceController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      haveAppBar: true,
      backgroundColorAppColor: AppColors.background,
      backgroundColor: AppColors.background,
      drawerIconColor: AppColors.primary,
      showBackButton: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CustomText(
              text: 'الــدورات التدريبيــة',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 22.sp,
                fontWeight: FontWeightHelper.regular,
              ),
            ),
          ),
          Gap(15.h),
          AddLectureButtonWidget(
            isAddingLecture: isAddingLecture,
            toggleAddLecture: () {
              setState(() {
                isAddingLecture = !isAddingLecture; // Toggle visibility
              });
            },
          ),
          if (isAddingLecture)
            AddLectureFormWidget(
              courseNameController: courseNameController,
              contentController: contentController,
              sourceController: sourceController,
              addLecture: addLecture,
            ),
          SizedBox(height: 16.h),
          LectureListWidget(
            lectures: lectures,
            onDeleteLecture: (index) {
              setState(() {
                lectures.removeAt(index);
              });
            },
          ),
        ],
      ),
    );
  }
}
