import 'package:masarat/core/config.dart';

/// Constants for the Student Cart API endpoints
class StudentCartApiConstants {
  /// Base URL for API
  static String get apiBaseUrl => Config.get('apiUrl') as String;

  /// Base path for API
  static const String baseApi = 'api/v1';

  /// Path for getting cart
  static const String getCart = 'api/v1/cart';

  /// Path for removing course from cart
  static const String removeCartItem = 'api/v1/cart/items';

  /// Path for adding course to cart
  static const String addToCart = 'api/v1/cart/items';
}
