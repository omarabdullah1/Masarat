import 'package:masarat/core/config.dart';

class InstructorApiConstants {
  static String get apiBaseUrl => Config.get('apiUrl') as String;

  static const String instructorCourses = 'api/courses/my-courses';

  static const String createCourse = 'api/courses';

  static const String categories = 'api/categories';

  static const String addLesson = 'api/lessons';

  static String imageUrl(String image) => '$apiBaseUrl$image';
}
