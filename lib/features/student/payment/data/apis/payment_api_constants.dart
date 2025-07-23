import 'package:masarat/core/config.dart';

/// Constants for the Payment API endpoints
class PaymentApiConstants {
  /// Base URL for API
  static String get apiBaseUrl => Config.get('apiUrl') as String;

  /// Base path for API
  static const String baseApi = 'api/v1';

  /// Path for initiating checkout
  static const String initiateCheckout = 'checkout/initiate';
}
