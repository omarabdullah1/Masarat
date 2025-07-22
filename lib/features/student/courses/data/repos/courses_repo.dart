import 'dart:developer';

import 'package:masarat/core/networking/api_error_handler.dart';
import 'package:masarat/core/networking/api_result.dart';
import 'package:masarat/features/student/courses/apis/courses_service.dart';
import 'package:masarat/features/student/courses/data/models/courses_response.dart';
import 'package:masarat/features/student/courses/data/models/lesson_details_model.dart';

class CoursesRepo {
  CoursesRepo(this._apiService);
  final CoursesService _apiService;

  Future<ApiResult<CoursesResponse>> getCourses({
    String? categoryId,
    String? level,
    int? limit,
    int? page,
    String? search,
  }) async {
    try {
      final response = await _apiService.getCourses(
        categoryId: categoryId,
        level: level,
        limit: limit,
        page: page,
        search: search,
      );
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      log('Get courses error: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<LessonDetailsModel>> getLessonDetails(
      String lessonId) async {
    try {
      log('Fetching lesson details for ID: $lessonId');
      final response = await _apiService.getLessonDetails(lessonId);
      log('Got lesson details response: ${response.title}, videoId: ${response.videoId}, videoLibraryId: ${response.videoLibraryId}');
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      log('Get lesson details error: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
