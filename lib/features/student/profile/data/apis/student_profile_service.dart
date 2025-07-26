import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'student_profile_service.g.dart';

@RestApi()
abstract class StudentProfileService {
  factory StudentProfileService(Dio dio, {String baseUrl}) =
      _StudentProfileService;

  @GET('/api/v1/auth/me')
  Future<dynamic> getProfile();

  @PUT('/api/v1/users/me')
  @MultiPart()
  Future<dynamic> updateProfile(@Body() FormData data);
}
