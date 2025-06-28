import 'dart:developer';

import 'package:masarat/core/networking/api_error_handler.dart';
import 'package:masarat/core/networking/api_result.dart';
import 'package:masarat/features/instructor/data/apis/instructor_service.dart';
import 'package:masarat/features/instructor/data/models/course/instructor_courses_response.dart';

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
}
