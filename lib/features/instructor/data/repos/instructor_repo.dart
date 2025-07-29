import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
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
  /// Create course with multipart/form-data (for file upload)
  Future<ApiResult<CreateCourseResponse>> createCourseMultipart({
    required String title,
    required String description,
    required String category,
    required String level,
    required String durationEstimate,
    required String tags,
    required double price,
    required PlatformFile coverImage,
  }) async {
    try {
      final dio = Dio();
      dio.options.baseUrl = InstructorApiConstants.apiBaseUrl;

      // Retrieve token and add Authorization header
      final token =
          await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
      if (token == null || token.isEmpty) {
        log('No auth token found for multipart course creation');
        return ApiResult.failure(
            ApiErrorHandler.handle('Not authorized, no token'));
      }
      dio.options.headers['Authorization'] = 'Bearer $token';

      // Determine contentType based on file extension
      String? ext = coverImage.extension?.toLowerCase();
      MediaType? mediaType;
      if (ext == 'jpg' || ext == 'jpeg') {
        mediaType = MediaType('image', 'jpeg');
      } else if (ext == 'png') {
        mediaType = MediaType('image', 'png');
      } else if (ext == 'gif') {
        mediaType = MediaType('image', 'gif');
      } else if (ext == 'pdf') {
        mediaType = MediaType('application', 'pdf');
      }

      final formData = FormData.fromMap({
        'title': title,
        'description': description,
        'category': category,
        'level': level,
        'durationEstimate': durationEstimate,
        'tags': tags,
        'price': price,
        'coverImage': MultipartFile.fromBytes(
          coverImage.bytes!,
          filename: coverImage.name,
          contentType: mediaType,
        ),
      });

      final response = await dio.post(
        InstructorApiConstants.createCourse,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
      return ApiResult.success(CreateCourseResponse.fromJson(response.data));
    } catch (error, stackTrace) {
      log('Create course (multipart) error: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

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

  /// Update course with multipart/form-data (for file upload)
  Future<ApiResult<UpdateCourseResponse>> updateCourseMultipart({
    required String courseId,
    required String title,
    required String description,
    required String category,
    required String level,
    required String durationEstimate,
    required String tags,
    required double price,
    required PlatformFile coverImage,
  }) async {
    try {
      final dio = Dio();
      dio.options.baseUrl = InstructorApiConstants.apiBaseUrl;

      // Retrieve token and add Authorization header
      final token =
          await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
      if (token == null || token.isEmpty) {
        log('No auth token found for multipart course update');
        return ApiResult.failure(
            ApiErrorHandler.handle('Not authorized, no token'));
      }
      dio.options.headers['Authorization'] = 'Bearer $token';

      // Determine contentType based on file extension
      String? ext = coverImage.extension?.toLowerCase();
      MediaType? mediaType;
      if (ext == 'jpg' || ext == 'jpeg') {
        mediaType = MediaType('image', 'jpeg');
      } else if (ext == 'png') {
        mediaType = MediaType('image', 'png');
      } else if (ext == 'gif') {
        mediaType = MediaType('image', 'gif');
      } else if (ext == 'pdf') {
        mediaType = MediaType('application', 'pdf');
      }

      final formData = FormData.fromMap({
        'title': title,
        'description': description,
        'category': category,
        'level': level,
        'durationEstimate': durationEstimate,
        'tags': tags,
        'price': price,
        'coverImage': MultipartFile.fromBytes(
          coverImage.bytes!,
          filename: coverImage.name,
          contentType: mediaType,
        ),
      });

      final response = await dio.put(
        '${InstructorApiConstants.updateCourse}/$courseId',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
      return ApiResult.success(UpdateCourseResponse.fromJson(response.data));
    } catch (error, stackTrace) {
      log('Update course (multipart) error: $error', stackTrace: stackTrace);
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

  Future<ApiResult<void>> deleteCourse(String courseId) async {
    try {
      // Use the same endpoint as updateCourse but with DELETE method
      final response = await _apiService.deleteCourse(courseId);
      return const ApiResult.success(null);
    } catch (error, stackTrace) {
      log('Delete Course error: $error', stackTrace: stackTrace);
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

        // Create a specialized Dio instance with optimized settings for uploads
        // Use more aggressive timeouts and settings
        final dio = Dio()
          ..options.baseUrl = InstructorApiConstants.apiBaseUrl
          ..options.connectTimeout = const Duration(seconds: 15)
          ..options.receiveTimeout = const Duration(seconds: 30)
          ..options.sendTimeout = const Duration(seconds: 30)
          // More aggressive buffer size and keep-alive settings
          ..options.listFormat = ListFormat.multiCompatible
          ..options.validateStatus = (status) => status != null && status < 400;

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

        log('Preparing FormData for upload with optimized settings');

        // Read the file bytes for more controlled upload
        final fileBytes = await videoFile.readAsBytes();
        final filename = videoFile.path.split(Platform.pathSeparator).last;

        log('File loaded into memory: ${fileBytes.length} bytes');

        // Create optimized FormData
        final formData = FormData();
        formData.files.add(MapEntry(
          'videoFile',
          MultipartFile.fromBytes(
            fileBytes,
            filename: filename,
            // Use smaller chunk size to avoid hanging on large data chunks
            contentType: MediaType.parse('video/*'),
          ),
        ));

        log('Sending upload request with stall detection');
        final stopwatch = Stopwatch()..start();

        // Create a completer to handle the upload with timeout
        final completer = Completer<Response>();

        // Set up a timer to detect stalled uploads - more aggressive detection
        final stallTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
          final now = DateTime.now().millisecondsSinceEpoch;
          final elapsedSinceLastProgress = now - lastProgressUpdateTime;

          // If no progress for 10 seconds, consider it stalled (more sensitive than before)
          if (elapsedSinceLastProgress > 10000 && !completer.isCompleted) {
            timer.cancel();
            log('Upload appears to be stalled at ${lastBytesSent / 1024} KB - cancelling current attempt');
            completer.completeError(DioException(
              requestOptions: RequestOptions(path: endpoint),
              error: 'Upload stalled - no progress detected for 10 seconds',
              type: DioExceptionType.connectionTimeout,
            ));
          }
        });
        dio.post(
          endpoint,
          data: formData,
          options: Options(
            // Set additional headers to improve upload performance
            headers: {
              'Connection': 'keep-alive',
              'Keep-Alive': 'timeout=15, max=100',
              'Content-Type': 'multipart/form-data',
            },
            // Set a specific content length to avoid issues with chunking
            contentType: 'multipart/form-data',
          ),
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

                // Extra diagnostics for the point where it usually stalls
                if (sent > 300000 && sent < 350000) {
                  log('Approaching critical section (31%) - actively monitoring progress');
                }
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
