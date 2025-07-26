import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'instructor_profile_service.g.dart';

@RestApi()
abstract class InstructorProfileService {
  factory InstructorProfileService(Dio dio, {String? baseUrl}) =
      _InstructorProfileService;

  @GET('/api/v1/auth/me')
  Future<dynamic> getProfile();

  @PUT('/api/v1/users/me')
  @MultiPart()
  Future<dynamic> updateProfile(@Body() FormData data);
}
