import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masarat/features/courses/data/models/add_lesson_request_body.dart';
import 'package:masarat/features/courses/data/repos/courses_repo.dart';
import 'package:masarat/features/courses/logic/cubit/add_lesson_state.dart';

class AddLessonCubit extends Cubit<AddLessonState> {
  AddLessonCubit(this._coursesRepo) : super(const AddLessonState.initial());

  final CoursesRepo _coursesRepo;

  Future<void> addLesson(AddLessonRequestBody requestBody) async {
    emit(const AddLessonState.loading());

    final result = await _coursesRepo.addLesson(requestBody);

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
