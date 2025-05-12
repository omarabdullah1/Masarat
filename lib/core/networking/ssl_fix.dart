import 'dart:developer';
import 'package:masarat/core/networking/dio_factory.dart';

/// Utility class to handle SSL certificate issues
class SslFix {
  /// Applies the SSL certificate bypass to fix expired certificate issues
  static Future<void> apply() async {
    try {
      log('Applying SSL certificate bypass...');
      await DioFactory.resetDio();
      log('SSL certificate bypass successfully applied');
    } catch (e) {
      log('Error applying SSL certificate bypass: $e');
    }
  }
}
