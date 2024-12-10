import 'package:flutter/material.dart';
import 'package:masarat/features/courses/presentation/widgets/lecture_item_widget.dart';

class LectureListWidget extends StatelessWidget {

  const LectureListWidget({
    super.key,
    required this.lectures,
    required this.onDeleteLecture,
  });
  final List<String> lectures;
  final Function(int) onDeleteLecture;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: lectures.length,
        itemBuilder: (context, index) {
          return LectureItemWidget(
            lecture: lectures[index],
            onDelete: () => onDeleteLecture(index),
          );
        },
      ),
    );
  }
}