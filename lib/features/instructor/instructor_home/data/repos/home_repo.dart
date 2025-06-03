import 'dart:developer';

import 'package:masarat/core/networking/api_error_handler.dart';
import 'package:masarat/core/networking/api_result.dart';
import 'package:masarat/features/instructor/instructor_home/data/apis/home_service.dart';
import 'package:masarat/features/instructor/instructor_home/data/models/published_courses_response.dart';

class HomeRepo {
  HomeRepo(this._apiService);
  final HomeService _apiService;

  Future<ApiResult<PublishedCoursesResponse>> getPublishedCourses({
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
}
