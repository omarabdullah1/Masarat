import 'package:dio/dio.dart';
import 'package:masarat/features/instructor/instructor_home/data/models/published_courses_response.dart';
import 'package:retrofit/retrofit.dart';

import 'home_api_constants.dart';

part 'home_service.g.dart';

// Use empty string for baseUrl, we'll set it in Dio instance
@RestApi()
abstract class HomeService {
  factory HomeService(Dio dio) {
    // Set the base URL from config on the dio instance
    dio.options.baseUrl = HomeApiConstants.apiBaseUrl;
    return _HomeService(dio);
  }

  @GET(HomeApiConstants.instructorPublishedCourses)
  Future<PublishedCoursesResponse> getPublishedCourses({
    @Query("category") String? categoryId,
    @Query("level") String? level,
    @Query("limit") int? limit,
    @Query("page") int? page,
  });
}
