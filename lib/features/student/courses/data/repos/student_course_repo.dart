import 'dart:developer';

import 'package:masarat/core/networking/api_error_handler.dart';
import 'package:masarat/core/networking/api_result.dart';
import 'package:masarat/features/student/courses/data/apis/student_course_service.dart';
import 'package:masarat/features/student/courses/data/models/lesson_model.dart';

class StudentCourseRepo {
  final StudentCourseService _apiService;

  StudentCourseRepo(this._apiService);

  Future<ApiResult<List<LessonModel>>> getLessons(String courseId) async {
    try {
      final response = await _apiService.getLessons(courseId);
      return ApiResult.success(response);
    } catch (e, stackTrace) {
      log('Error getting lessons: $e');
      log('Stack trace: $stackTrace');
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
