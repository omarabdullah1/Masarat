import 'package:dio/dio.dart';
import 'package:masarat/features/instructor/data/models/course/instructor_courses_response.dart';
import 'package:masarat/features/instructor/data/models/course/update_course_request_body.dart';
import 'package:masarat/features/instructor/data/models/course/update_course_response.dart';
import 'package:retrofit/retrofit.dart';

import '../models/add_lesson/add_lesson_request_body.dart';
import '../models/add_lesson/add_lesson_response.dart';
import '../models/category/category_model.dart';
import '../models/course/create_course_request_body.dart';
import '../models/course/create_course_response.dart';
import '../models/lesson/lesson_model.dart';
import 'instructor_api_constants.dart';

part 'instructor_service.g.dart';

// Use empty string for baseUrl, we'll set it in Dio instance
@RestApi()
abstract class InstructorService {
  factory InstructorService(Dio dio) {
    // Set the base URL from config on the dio instance
    dio.options.baseUrl = InstructorApiConstants.apiBaseUrl;
    return _InstructorService(dio);
  }

  @GET(InstructorApiConstants.instructorCourses)
  Future<InstructorCoursesResponse> getPublishedCourses({
    @Query("category") String? categoryId,
    @Query("level") String? level,
    @Query("limit") int? limit,
    @Query("page") int? page,
  });
  @POST(InstructorApiConstants.createCourse)
  Future<CreateCourseResponse> createCourse(
    @Body() CreateCourseRequestBody createCourseRequestBody,
  );

  @PUT('api/courses/{courseId}')
  Future<UpdateCourseResponse> updateCourse(
    @Path('courseId') String courseId,
    @Body() UpdateCourseRequestBody updateCourseRequestBody,
  );

  @GET(InstructorApiConstants.categories)
  Future<List<CategoryModel>> getCategories();

  @POST(InstructorApiConstants.addLesson)
  Future<AddLessonResponse> addLesson(
    @Body() AddLessonRequestBody addLessonRequestBody,
  );

  @GET('${InstructorApiConstants.getLessons}/{courseId}')
  Future<List<LessonModel>> getLessons(
    @Path("courseId") String courseId,
  );

  @DELETE('${InstructorApiConstants.deleteLesson}/{lessonId}')
  Future<void> deleteLesson(
    @Path("lessonId") String lessonId,
  );

  @PUT('${InstructorApiConstants.updateLesson}/{lessonId}')
  Future<LessonModel> updateLesson(
    @Path("lessonId") String lessonId,
    @Body() Map<String, dynamic> lessonData,
  );
}
