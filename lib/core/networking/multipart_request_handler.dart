import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

/// A handler for multipart requests that creates fresh FormData for each retry attempt
class MultipartRequestHandler {
  const MultipartRequestHandler();

  /// Executes a multipart POST request with proper handling for retries
  /// This ensures a fresh FormData is created for each attempt
  Future<dynamic> uploadFile({
    required Dio dio,
    required String endpoint,
    required String fileParamName,
    required File file,
    Map<String, dynamic>? extraParams,
    Map<String, dynamic>? queryParams,
    int maxRetries = 3,
    Duration retryDelay = const Duration(seconds: 2),
  }) async {
    int attempts = 0;
    late DioException lastException;

    while (attempts < maxRetries) {
      attempts++;
      try {
        // Create fresh FormData for each attempt
        final formData = FormData();

        // Add the file
        formData.files.add(MapEntry(
          fileParamName,
          MultipartFile.fromFileSync(
            file.path,
            filename: file.path.split(Platform.pathSeparator).last,
          ),
        ));

        // Add any extra parameters if provided
        extraParams?.forEach((key, value) {
          formData.fields.add(MapEntry(key, value.toString()));
        });

        // Execute the request
        final response = await dio.post(
          endpoint,
          data: formData,
          queryParameters: queryParams,
        );

        return response.data;
      } on DioException catch (e) {
        lastException = e;

        // Only retry for connection-related errors
        if (e.type != DioExceptionType.connectionError &&
            e.type != DioExceptionType.connectionTimeout &&
            e.type != DioExceptionType.receiveTimeout &&
            e.type != DioExceptionType.sendTimeout) {
          log('Not retrying due to non-connection error: ${e.type}');
          rethrow;
        }

        // Don't retry on the last attempt
        if (attempts >= maxRetries) {
          log('Max retry attempts ($maxRetries) reached');
          rethrow;
        }

        // Wait before retrying
        log('Retrying upload... Attempt $attempts/$maxRetries after ${retryDelay.inSeconds}s');
        await Future.delayed(retryDelay * attempts);
      }
    }

    throw lastException;
  }
}
