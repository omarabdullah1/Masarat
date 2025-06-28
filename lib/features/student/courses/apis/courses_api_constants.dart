import 'package:masarat/core/config.dart';

class CoursesApiConstants {
  static String get apiBaseUrl => Config.get('apiUrl') as String;

  static const String createCourse = 'api/courses';
  static const String categories = 'api/categories';
  static const String addLesson = 'api/lessons';
}
