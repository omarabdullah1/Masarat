import 'package:masarat/core/config.dart';

class HomeApiConstants {
  static String get apiBaseUrl => Config.get('apiUrl') as String;

  static const String instructorCourses = 'api/courses/my-courses';
  static const String categories = 'api/categories';

  static String imageUrl(String image) => '$apiBaseUrl$image';
}
