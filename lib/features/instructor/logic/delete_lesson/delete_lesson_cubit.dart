import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masarat/features/instructor/data/repos/instructor_repo.dart';
import 'package:masarat/features/instructor/logic/delete_lesson/delete_lesson_state.dart';

class DeleteLessonCubit extends Cubit<DeleteLessonState> {
  DeleteLessonCubit(this._instructorRepo)
      : super(const DeleteLessonState.initial());

  final InstructorRepo _instructorRepo;

  Future<void> deleteLesson(String lessonId) async {
    emit(const DeleteLessonState.loading());

    final result = await _instructorRepo.deleteLesson(lessonId);

    result.when(
      success: (data) => emit(const DeleteLessonState.success()),
      failure: (error) => emit(
          DeleteLessonState.error(error.message ?? 'Failed to delete lesson')),
    );
  }
}
