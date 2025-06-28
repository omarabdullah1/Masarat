import 'package:dio/dio.dart';
import 'package:masarat/features/auth/apis/auth_api_constants.dart';
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
}
