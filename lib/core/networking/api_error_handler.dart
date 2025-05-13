import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:masarat/core/networking/api_error_model.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    if (error is DioException) {
      // Log error details for debugging
      log('DioException: ${error.type}');
      log('Error response: ${error.response?.data}');
      log('Status code: ${error.response?.statusCode}');

      // Check if this is resolved with a cached response
      final isFromCache =
          error.response?.headers.value('x-from-cache') == 'true';

      if (isFromCache) {
        // This error has been resolved with cached data
        return ApiErrorModel(
          message:
              'Showing cached data due to network issues. Pull to refresh when back online.',
          error: 'Using Cached Data',
        );
      }

      switch (error.type) {
        case DioExceptionType.connectionError:
          if (error.error == 'No internet connection') {
            return ApiErrorModel(
              message:
                  'No internet connection. Please check your network settings.',
              error: 'Offline',
            );
          }
          return ApiErrorModel(message: 'Connection to server failed');
        case DioExceptionType.cancel:
          return ApiErrorModel(message: 'Request to the server was cancelled');
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(
            message:
                'Connection timed out. Please check your internet connection and try again.',
            error: 'Connection Timeout',
          );
        case DioExceptionType.unknown:
          return ApiErrorModel(
            message: 'Unknown error occurred, please try again later',
          );
        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(
            message: 'Receive timeout. Server is taking too long to respond.',
            error: 'Receive Timeout',
          );
        case DioExceptionType.badResponse:
          // Check specifically for 504 Gateway Timeout
          if (error.response?.statusCode == 504) {
            return ApiErrorModel(
              message:
                  'Server is taking too long to respond. Check your connection or try again later.',
              error: 'Gateway Timeout',
            );
          } else if (error.response?.statusCode == 503) {
            return ApiErrorModel(
              message:
                  'Service unavailable. Please try again in a few moments.',
              error: 'Service Unavailable',
            );
          }
          return _handleError(error.response?.data);
        case DioExceptionType.sendTimeout:
          return ApiErrorModel(
            message: 'Send timeout. Request took too long to complete.',
            error: 'Send Timeout',
          );
        case DioExceptionType.badCertificate:
          return ApiErrorModel(
            message: 'Bad certificate. Please check your SSL settings.',
            error: 'Bad Certificate',
          );
      }
    } else {
      log('Non-Dio error: $error');
      return ApiErrorModel(message: 'Unknown error occurred');
    }
  }
}

ApiErrorModel _handleError(dynamic data) {
  if (data == null) return ApiErrorModel(message: 'Unknown error occurred');

  log('Handling error response: $data');

  // Check if data is already a Map, if not try to decode it
  final errorData = data is Map
      ? data as Map<String, dynamic>
      : {'message': 'Unknown error occurred'};

  // Look for error messages in different possible formats
  String? errorMessage;
  String? errorCode;

  if (errorData.containsKey('error')) {
    errorMessage = errorData['error']?.toString();
    errorCode = 'Error';
  } else if (errorData.containsKey('message')) {
    errorMessage = errorData['message']?.toString();
    errorCode = errorData['code']?.toString() ?? 'Error';
  }

  return ApiErrorModel(
    message: errorMessage ?? 'Unknown error occurred',
    error: errorCode,
  );
}
