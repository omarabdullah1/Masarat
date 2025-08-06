import 'package:masarat/core/config.dart';

class InstructorApiConstants {
  static String get apiBaseUrl => Config.get('apiUrl') as String;

  static const String instructorCourses = 'api/v1/courses/my-courses';
  static const String createCourse = 'api/v1/courses';
  static const String updateCourse = 'api/v1/courses';
  static const String categories = 'api/v1/categories';
  static const String addLesson = 'api/v1/lessons/new';
  static const String getLessons = 'api/v1/lessons/course';
  static const String deleteLesson = 'api/v1/lessons';
  static const String updateLesson = 'api/v1/lessons';
  static const String uploadLessonVideo = 'api/v1/lessons/{lessonId}/video';

  static String imageUrl(String image) {
    if (image.startsWith('http')) {
      return image;
    }
    // Remove trailing slash from base URL and leading slash from image path
    final base = apiBaseUrl.endsWith('/')
        ? apiBaseUrl.substring(0, apiBaseUrl.length - 1)
        : apiBaseUrl;
    final path = image.startsWith('/') ? image.substring(1) : image;
    return '$base/$path';
  }
}
