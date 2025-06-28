import 'package:dio/dio.dart';
import 'package:masarat/features/auth/apis/auth_api_constants.dart';
import 'package:masarat/features/courses/apis/courses_api_constants.dart';
import 'package:masarat/features/courses/data/models/add_lesson_request_body.dart';
import 'package:masarat/features/courses/data/models/add_lesson_response.dart';
import 'package:masarat/features/courses/data/models/category_model.dart';
import 'package:masarat/features/courses/data/models/create_course_request_body.dart';
import 'package:masarat/features/courses/data/models/create_course_response.dart';
import 'package:retrofit/retrofit.dart';

part 'courses_service.g.dart';

// Use empty string for baseUrl, we'll set it in Dio instance
@RestApi()
abstract class CoursesService {
  factory CoursesService(Dio dio) {
    // Set the base URL from config on the dio instance
    dio.options.baseUrl = AuthenticationApiConstants.apiBaseUrl;
    return _CoursesService(dio);
  }

  @POST(CoursesApiConstants.createCourse)
  Future<CreateCourseResponse> createCourse(
    @Body() CreateCourseRequestBody createCourseRequestBody,
  );

  @GET(CoursesApiConstants.categories)
  Future<List<CategoryModel>> getCategories();

  @POST(CoursesApiConstants.addLesson)
  Future<AddLessonResponse> addLesson(
    @Body() AddLessonRequestBody addLessonRequestBody,
  );
}
