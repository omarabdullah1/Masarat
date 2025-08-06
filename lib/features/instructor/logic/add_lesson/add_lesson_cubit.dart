import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masarat/features/instructor/data/repos/instructor_repo.dart';
import 'package:masarat/features/instructor/logic/add_lesson/add_lesson_state.dart';

import '../../data/models/add_lesson/add_lesson_request_body.dart';

class AddLessonCubit extends Cubit<AddLessonState> {
  AddLessonCubit(this._instructorRepo) : super(const AddLessonState.initial());

  final InstructorRepo _instructorRepo;

  Future<void> addLesson(AddLessonRequestBody requestBody) async {
    emit(const AddLessonState.loading());

    final result = await _instructorRepo.addLessonMultipart(
      title: requestBody.title,
      contentType: requestBody.contentType,
      courseId: requestBody.courseId,
      order: requestBody.order,
      isPreviewable: requestBody.isPreviewable,
      videoFile:
          requestBody.videoFile != null && requestBody.videoFile!.path != null
              ? File(requestBody.videoFile!.path!)
              : null,
      resources: requestBody.resources
              ?.where((f) => f.path != null)
              .map((f) => File(f.path!))
              .toList() ??
          [],
      content: requestBody.content,
    );

    result.when(
      success: (data) {
        log('Add Lesson success: $data');
        emit(AddLessonState.success(data));
      },
      failure: (error) {
        log('Add Lesson error: ${error.message}');
        emit(AddLessonState.error(error: error.message ?? 'Unknown error'));
      },
    );
  }

  void resetState() {
    emit(const AddLessonState.initial());
  }
}
