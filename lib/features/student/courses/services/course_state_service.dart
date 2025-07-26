import 'package:masarat/features/student/courses/data/models/course_model.dart';
import 'package:masarat/features/student/courses/data/models/lesson_model.dart';

/// A service class to maintain state of the currently selected course
/// This allows us to access the course data from anywhere in the app
class CourseStateService {
  static final CourseStateService _instance = CourseStateService._internal();

  factory CourseStateService() {
    return _instance;
  }

  CourseStateService._internal();

  CourseModel? _selectedCourse;
  final Map<String, List<LessonModel>> _courseLessons = {};

  /// Get the currently selected course
  CourseModel? get selectedCourse => _selectedCourse;

  /// Set the currently selected course
  set selectedCourse(CourseModel? course) {
    _selectedCourse = course;
  }

  /// Clear the selected course data
  void clearSelectedCourse() {
    _selectedCourse = null;
  }

  /// Store lessons fetched from API for a specific course
  void storeLessonsForCourse(String courseId, List<LessonModel> lessons) {
    _courseLessons[courseId] = lessons;
  }

  /// Get lessons for a specific course if available
  List<LessonModel>? getLessonsForCourse(String courseId) {
    return _courseLessons[courseId];
  }

  /// Get a specific lesson by ID from the stored API lessons
  LessonModel? getLessonById(String lessonId) {
    for (var lessons in _courseLessons.values) {
      for (var lesson in lessons) {
        if (lesson.id == lessonId) {
          return lesson;
        }
      }
    }
    return null;
  }
}
