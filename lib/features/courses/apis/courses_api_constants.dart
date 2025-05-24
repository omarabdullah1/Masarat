import 'package:masarat/core/config.dart';

class CoursesApiConstants {
  static String get apiBaseUrl => Config.get('apiUrl') as String;

  static const String courses = 'api/courses';
  static const String createCourse = 'api/courses';
  static const String categories = 'api/categories';
}
