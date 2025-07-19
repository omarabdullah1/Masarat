import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masarat/features/instructor/data/repos/instructor_repo.dart';
import 'package:masarat/features/instructor/logic/update_lesson/update_lesson_state.dart';

class UpdateLessonCubit extends Cubit<UpdateLessonState> {
  final InstructorRepo _instructorRepo;

  UpdateLessonCubit(this._instructorRepo)
      : super(const UpdateLessonState.initial());

  Future<void> updateLesson(
    String lessonId,
    String title,
    String contentType,
    String content,
    int order,
    String durationEstimate,
    bool isPreviewable,
  ) async {
    emit(const UpdateLessonState.loading());

    final lessonData = {
      'title': title,
      'contentType': contentType,
      'content': content,
      'order': order,
      'durationEstimate': durationEstimate,
      'isPreviewable': isPreviewable,
    };

    final result = await _instructorRepo.updateLesson(lessonId, lessonData);

    result.when(
      success: (lesson) {
        log('Update Lesson success: $lesson');
        emit(UpdateLessonState.success(lesson));
      },
      failure: (error) {
        log('Update Lesson error: ${error.message}');
        emit(UpdateLessonState.error(error.message ?? 'Unknown error'));
      },
    );
  }

  void resetState() {
    emit(const UpdateLessonState.initial());
  }
}
