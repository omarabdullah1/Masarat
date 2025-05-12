import 'package:flutter/material.dart';
import 'package:masarat/features/courses/presentation/widgets/lecture_item_widget.dart';

class LectureListWidget extends StatelessWidget {
  const LectureListWidget({
    required this.lectures,
    required this.onDeleteLecture,
    super.key,
  });
  final List<String> lectures;
  final void Function(int) onDeleteLecture;

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
