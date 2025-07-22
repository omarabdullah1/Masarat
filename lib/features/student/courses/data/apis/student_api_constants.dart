import 'package:masarat/core/config.dart';

/// Constants for the Student API endpoints
class StudentApiConstants {
  /// Base URL for API
  static String get apiBaseUrl => Config.get('apiUrl') as String;

  /// Base path for API
  static const String baseApi = 'api/v1';

  /// Path for getting lessons for a course
  static const String getLessons = 'api/v1/lessons/course';
}
