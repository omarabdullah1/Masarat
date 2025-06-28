import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masarat/features/instructor/data/repos/instructor_repo.dart';
import 'package:masarat/features/instructor/logic/get_lessons/get_lessons_state.dart';

class GetLessonsCubit extends Cubit<GetLessonsState> {
  GetLessonsCubit(this._instructorRepo)
      : super(const GetLessonsState.initial());

  final InstructorRepo _instructorRepo;

  Future<void> getLessons(String courseId) async {
    emit(const GetLessonsState.loading());
    log('Getting lessons for course: $courseId');

    final result = await _instructorRepo.getLessons(courseId);

    result.when(
      success: (lessons) {
        log('Lessons fetched successfully: ${lessons.length} lessons');
        emit(GetLessonsState.success(lessons));
      },
      failure: (error) {
        log('Get lessons error: ${error.message}');
        emit(GetLessonsState.error(error.message ?? 'Unknown error occurred'));
      },
    );
  }
}
