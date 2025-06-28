import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masarat/features/instructor/data/models/add_lesson/add_lesson_request_body.dart';
import 'package:masarat/features/instructor/data/repos/instructor_repo.dart';
import 'package:masarat/features/instructor/logic/add_lesson/add_lesson_state.dart';

class AddLessonCubit extends Cubit<AddLessonState> {
  AddLessonCubit(this._instructorRepo) : super(const AddLessonState.initial());

  final InstructorRepo _instructorRepo;

  Future<void> addLesson(AddLessonRequestBody requestBody) async {
    emit(const AddLessonState.loading());

    final result = await _instructorRepo.addLesson(requestBody);

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
