import 'package:masarat/core/config.dart';

class CoursesApiConstants {
  static String get apiBaseUrl => Config.get('apiUrl') as String;

  static const String createCourse = 'api/v1/courses';
  static const String categories = 'api/v1/categories';
  static const String addLesson = 'api/v1/lessons';
  static const String lessonDetails = 'api/v1/lessons/{lessonId}';

  // Video streaming URL pattern
  static const String videoStreamUrl =
      'video-library/{videoLibraryId}/videos/{videoId}/stream.m3u8';
}
