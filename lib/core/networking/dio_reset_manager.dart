import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:masarat/core/networking/dio_factory.dart';

/// A utility class to manage Dio client resets
/// Used to force recreation of the Dio client when needed
/// such as when SSL certificates need to be bypassed
class DioResetManager {
  /// Private constructor to prevent instantiation
  DioResetManager._();

  /// Resets the Dio client and ensures SSL certificate bypass is applied
  /// Returns a new Dio instance with the bypass enabled
  static Future<Dio> resetDioWithSslBypass() async {
    log('Resetting Dio client with SSL certificate bypass');
    return DioFactory.resetDio();
  }

  /// Applies the changes immediately to fix SSL certificate issues
  /// Call this method when the app starts if SSL issues are detected
  static Future<void> fixSslIssues() async {
    try {
      await resetDioWithSslBypass();
      log('Successfully applied SSL certificate bypass to Dio client');
    } catch (e) {
      log('Error applying SSL certificate bypass: $e');
    }
  }
}
