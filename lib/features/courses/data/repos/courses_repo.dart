import 'dart:developer';

import 'package:masarat/core/networking/api_error_handler.dart';
import 'package:masarat/core/networking/api_result.dart';
import 'package:masarat/features/courses/apis/courses_service.dart';
import 'package:masarat/features/courses/data/models/add_lesson_request_body.dart';
import 'package:masarat/features/courses/data/models/add_lesson_response.dart';
import 'package:masarat/features/courses/data/models/category_model.dart';
import 'package:masarat/features/courses/data/models/create_course_request_body.dart';
import 'package:masarat/features/courses/data/models/create_course_response.dart';

class CoursesRepo {
  CoursesRepo(this._apiService);
  final CoursesService _apiService;

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
}
