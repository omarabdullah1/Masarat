import 'package:masarat/core/config.dart';

class InstructorApiConstants {
  static String get apiBaseUrl => Config.get('apiUrl') as String;

  static const String instructorCourses = 'api/v1/courses/my-courses';
  static const String createCourse = 'api/v1/courses';
  static const String updateCourse = 'api/v1/courses';
  static const String categories = 'api/v1/categories';
  static const String addLesson = 'api/v1/lessons';
  static const String getLessons = 'api/v1/lessons/course';
  static const String deleteLesson = 'api/v1/lessons';
  static const String updateLesson = 'api/v1/lessons';
  static const String uploadLessonVideo = 'api/v1/lessons/{lessonId}/video';

  static String imageUrl(String image) => '$apiBaseUrl$image';
}
