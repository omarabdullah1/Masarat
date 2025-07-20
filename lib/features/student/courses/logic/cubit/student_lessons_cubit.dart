import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masarat/core/di/dependency_injection.dart';
import 'package:masarat/features/student/courses/data/repos/student_course_repo.dart';
import 'package:masarat/features/student/courses/logic/cubit/student_lessons_state.dart';
import 'package:masarat/features/student/courses/services/course_state_service.dart';

/// Cubit to manage fetching and displaying lessons for a student
class StudentLessonsCubit extends Cubit<StudentLessonsState> {
  StudentLessonsCubit(this._repo) : super(const StudentLessonsState.initial());

  final StudentCourseRepo _repo;
  final _courseService = getIt<CourseStateService>();

  /// Fetch lessons for a specific course
  Future<void> getLessons(String courseId) async {
    if (courseId.isEmpty) {
      emit(const StudentLessonsState.error('Course ID is required'));
      return;
    }

    emit(const StudentLessonsState.loading());

    final result = await _repo.getLessons(courseId);

    result.when(
      success: (lessons) {
        // Store lessons in the CourseStateService
        _courseService.storeLessonsForCourse(courseId, lessons);
        debugPrint('Stored ${lessons.length} lessons for course $courseId');

        // Log lesson content for debugging
        for (var lesson in lessons) {
          debugPrint('Lesson ${lesson.title}: content = ${lesson.content}');
        }

        emit(StudentLessonsState.success(lessons));
      },
      failure: (error) {
        emit(StudentLessonsState.error(
            error.message ?? 'Failed to load lessons'));
      },
    );
  }
}
