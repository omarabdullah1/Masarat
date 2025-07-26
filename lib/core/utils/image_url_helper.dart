import 'package:masarat/core/config.dart';

class ImageUrlHelper {
  /// Formats an image URL with the base API URL
  ///
  /// If the image URL already starts with http, it's considered a complete URL
  /// Otherwise, it appends the API base URL from Config
  static String formatImageUrl(String imageUrl) {
    if (imageUrl.isEmpty) {
      return '${Config.get('apiUrl')}uploads/courses/default_course_cover.jpg';
    }

    if (imageUrl.startsWith('http')) {
      return imageUrl;
    }

    final apiBaseUrl = Config.get('apiUrl').toString();

    // Make sure we don't have double slashes
    if (imageUrl.startsWith('/')) {
      return '$apiBaseUrl${imageUrl.substring(1)}';
    } else {
      return '$apiBaseUrl$imageUrl';
    }
  }

  /// Gets a default fallback image URL for courses
  static String get defaultCourseImage =>
      '${Config.get('apiUrl')}uploads/courses/default_course_cover.jpg';
}
