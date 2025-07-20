import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masarat/core/networking/api_error_model.dart';
import 'package:masarat/features/student/courses/data/repos/courses_repo.dart';
import 'package:masarat/features/student/courses/logic/lesson_details/lesson_details_state.dart';

class LessonDetailsCubit extends Cubit<LessonDetailsState> {
  LessonDetailsCubit(this._coursesRepo)
      : super(const LessonDetailsState.initial());

  final CoursesRepo _coursesRepo;

  Future<void> getLessonDetails(String lessonId) async {
    try {
      emit(const LessonDetailsState.loading());
      log('Fetching lesson details for ID: $lessonId');

      final result = await _coursesRepo.getLessonDetails(lessonId);

      result.when(
        success: (lessonDetails) {
          log('Got lesson details response: ${lessonDetails.title}, videoId: ${lessonDetails.videoId}, videoLibraryId: ${lessonDetails.videoLibraryId}');
          emit(LessonDetailsState.success(lessonDetails: lessonDetails));
        },
        failure: (error) {
          log('Get lesson details error: ${error.message}');
          emit(LessonDetailsState.error(error: error));
        },
      );
    } catch (e, s) {
      log('Error in getLessonDetails: $e', stackTrace: s);
      // Handle unexpected errors
      emit(LessonDetailsState.error(
        error: ApiErrorModel(
          message: 'An unexpected error occurred',
          error: 'Internal application error',
        ),
      ));
    }
  }
}
