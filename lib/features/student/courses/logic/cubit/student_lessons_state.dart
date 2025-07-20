import 'package:masarat/features/student/courses/data/models/lesson_model.dart';

enum StudentLessonsStatus {
  initial,
  loading,
  success,
  error,
}

class StudentLessonsState {
  final StudentLessonsStatus status;
  final List<LessonModel>? lessons;
  final String? errorMessage;

  const StudentLessonsState.initial()
      : status = StudentLessonsStatus.initial,
        lessons = null,
        errorMessage = null;

  const StudentLessonsState.loading()
      : status = StudentLessonsStatus.loading,
        lessons = null,
        errorMessage = null;

  const StudentLessonsState.success(this.lessons)
      : status = StudentLessonsStatus.success,
        errorMessage = null;

  const StudentLessonsState.error(this.errorMessage)
      : status = StudentLessonsStatus.error,
        lessons = null;
}
