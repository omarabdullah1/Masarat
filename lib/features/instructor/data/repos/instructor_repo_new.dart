import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:masarat/core/helpers/constants.dart';
import 'package:masarat/core/helpers/shared_pref_helper.dart';
import 'package:masarat/core/networking/api_error_handler.dart';
import 'package:masarat/core/networking/api_result.dart';
import 'package:masarat/features/instructor/data/apis/instructor_api_constants.dart';
import 'package:masarat/features/instructor/data/apis/instructor_service.dart';
import 'package:masarat/features/instructor/data/models/course/instructor_courses_response.dart';
import 'package:masarat/features/instructor/data/models/course/update_course_request_body.dart';
import 'package:masarat/features/instructor/data/models/course/update_course_response.dart';

import '../models/add_lesson/add_lesson_request_body.dart';
import '../models/add_lesson/add_lesson_response.dart';
import '../models/category/category_model.dart';
import '../models/course/create_course_request_body.dart';
import '../models/course/create_course_response.dart';
import '../models/lesson/lesson_model.dart';

class InstructorRepo {
  InstructorRepo(this._apiService);
  final InstructorService _apiService;

  Future<ApiResult<CreateCourseResponse>> createCourse(
    CreateCourseRequestBody createCourseRequestBody,
  ) async {
    try {
      final response = await _apiService.createCourse(createCourseRequestBody);
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      log('Create course error: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<UpdateCourseResponse>> updateCourse(
    String courseId,
    UpdateCourseRequestBody updateCourseRequestBody,
  ) async {
    try {
      final response =
          await _apiService.updateCourse(courseId, updateCourseRequestBody);
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      log('Update course error: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<CategoryModel>>> getCategories() async {
    try {
      final response = await _apiService.getCategories();
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      log('Get categories error: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<AddLessonResponse>> addLesson(
      AddLessonRequestBody requestBody) async {
    try {
      final response = await _apiService.addLesson(requestBody);
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      log('Add Lesson error: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<InstructorCoursesResponse>> getPublishedCourses({
    String? categoryId,
    String? level,
    int? limit,
    int? page,
  }) async {
    try {
      final response = await _apiService.getPublishedCourses(
        categoryId: categoryId,
        level: level,
        limit: limit,
        page: page,
      );
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      log('Get Published Courses error: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<LessonModel>>> getLessons(String courseId) async {
    try {
      final response = await _apiService.getLessons(courseId);
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      log('Get Lessons error: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<void>> deleteLesson(String lessonId) async {
    try {
      await _apiService.deleteLesson(lessonId);
      return const ApiResult.success(null);
    } catch (error, stackTrace) {
      log('Delete Lesson error: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<LessonModel>> updateLesson(
      String lessonId, Map<String, dynamic> lessonData) async {
    try {
      final response = await _apiService.updateLesson(lessonId, lessonData);
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      log('Update Lesson error: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<dynamic>> uploadLessonVideo(
      String lessonId, File videoFile) async {
    // Set up retry parameters
    const maxRetries = 3;
    int attempts = 0;
    DioException? lastError;

    while (attempts < maxRetries) {
      attempts++;
      try {
        log('Starting video upload attempt $attempts/$maxRetries for lesson $lessonId, file size: ${(videoFile.lengthSync() / 1024 / 1024).toStringAsFixed(2)} MB');

        // Create a custom Dio instance just for this upload with shorter timeouts
        // This helps detect stalled uploads faster
        final dio = Dio()
          ..options.baseUrl = InstructorApiConstants.apiBaseUrl
          ..options.connectTimeout = const Duration(seconds: 30)
          ..options.receiveTimeout = const Duration(seconds: 45)
          ..options.sendTimeout = const Duration(seconds: 60);

        // Add auth headers - get token from SharedPrefHelper
        final token =
            await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
        dio.options.headers = {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        };

        // Define endpoint first so it's available throughout the function
        final endpoint = 'api/v1/lessons/$lessonId/video';

        // Set up progress monitoring variables
        int lastProgressUpdateTime = DateTime.now().millisecondsSinceEpoch;
        int lastBytesSent = 0;

        log('Preparing FormData for upload');
        final formData = FormData();
        formData.files.add(MapEntry(
          'videoFile',
          await MultipartFile.fromFile(
            videoFile.path,
            filename: videoFile.path.split(Platform.pathSeparator).last,
          ),
        ));

        log('Sending upload request with stall detection');
        final stopwatch = Stopwatch()..start();

        // Create a completer to handle the upload with timeout
        final completer = Completer<Response>();

        // Set up a timer to detect stalled uploads
        final stallTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
          final now = DateTime.now().millisecondsSinceEpoch;
          final elapsedSinceLastProgress = now - lastProgressUpdateTime;

          // If no progress for 15 seconds, consider it stalled
          if (elapsedSinceLastProgress > 15000 && !completer.isCompleted) {
            timer.cancel();
            log('Upload appears to be stalled - cancelling current attempt');
            completer.completeError(DioException(
              requestOptions: RequestOptions(path: endpoint),
              error: 'Upload stalled - no progress detected for 15 seconds',
              type: DioExceptionType.connectionTimeout,
            ));
          }
        });

        dio.post(
          endpoint,
          data: formData,
          onSendProgress: (int sent, int total) {
            if (total != -1) {
              final percentage = (sent / total * 100).toStringAsFixed(2);
              log('Upload progress: $percentage% ($sent/$total bytes)');

              // Update progress tracking variables
              lastProgressUpdateTime = DateTime.now().millisecondsSinceEpoch;

              // Calculate upload speed
              final bytesSinceLastUpdate = sent - lastBytesSent;
              if (bytesSinceLastUpdate > 0) {
                final kbps = (bytesSinceLastUpdate / 1024).toStringAsFixed(2);
                log('Upload speed: $kbps KB/s');
              }
              lastBytesSent = sent;
            }
          },
        ).then((response) {
          stallTimer.cancel();
          if (!completer.isCompleted) {
            completer.complete(response);
          }
        }).catchError((error) {
          stallTimer.cancel();
          if (!completer.isCompleted) {
            completer.completeError(error);
          }
        });

        // Wait for either completion or timeout
        final response = await completer.future;

        stopwatch.stop();
        log('Upload completed in ${stopwatch.elapsed.inSeconds} seconds');

        return ApiResult.success(response.data);
      } catch (error, stackTrace) {
        if (error is DioException) {
          lastError = error;
          log('Upload attempt $attempts failed: ${error.message}');

          if (attempts >= maxRetries) {
            log('Max retry attempts reached. Giving up.');
            break;
          }

          // Calculate backoff time (with exponential backoff)
          final backoffSeconds = attempts * 2;
          log('Will retry in $backoffSeconds seconds...');
          await Future.delayed(Duration(seconds: backoffSeconds));
        } else {
          // For non-DioExceptions, don't retry
          log('Upload Lesson Video error: $error', stackTrace: stackTrace);
          return ApiResult.failure(ApiErrorHandler.handle(error));
        }
      }
    }

    // If we get here and lastError is not null, we've exhausted our retries
    log('Upload Lesson Video failed after $attempts attempts',
        stackTrace: lastError?.stackTrace);
    return ApiResult.failure(
      ApiErrorHandler.handle(lastError ??
          Exception('Failed to upload video after $attempts attempts')),
    );
  }
}
