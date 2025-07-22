import 'package:dio/dio.dart';
import 'package:masarat/features/student/courses/data/apis/student_api_constants.dart';
import 'package:masarat/features/student/courses/data/models/lesson_model.dart';
import 'package:retrofit/retrofit.dart';

part 'student_course_service.g.dart';

@RestApi()
abstract class StudentCourseService {
  factory StudentCourseService(Dio dio, {String baseUrl}) =
      _StudentCourseService;

  @GET('${StudentApiConstants.getLessons}/{courseId}')
  Future<List<LessonModel>> getLessons(
    @Path('courseId') String courseId,
  );
}
