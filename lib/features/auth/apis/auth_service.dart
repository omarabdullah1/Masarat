import 'package:dio/dio.dart';
import 'package:masarat/features/auth/apis/auth_api_constants.dart';
import 'package:masarat/features/auth/login/data/models/login_request_body.dart';
import 'package:masarat/features/auth/login/data/models/login_response.dart';
import 'package:masarat/features/auth/signup/data/models/create_account_request_body.dart';
import 'package:masarat/features/auth/signup/data/models/create_account_response.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_service.g.dart';

@RestApi(baseUrl: AuthenticationApiConstants.apiBaseUrl)
abstract class AuthenticationService {
  factory AuthenticationService(Dio dio) = _AuthenticationService;

  @POST(AuthenticationApiConstants.login)
  Future<LoginResponse> login(
    @Body() LoginRequestBody loginRequestBody,
  );

  @POST(AuthenticationApiConstants.createAccount)
  Future<CreateAccountResponse> createAccount(
    @Body() CreateAccountRequestBody createAccountRequestBody,
  );

  // @POST(AuthenticationApiConstants.forget)
  // Future<ForgetPasswordResponse> forgetPassword(
  //   @Body() ForgetPasswordRequest forgetPasswordRequest,
  // );

  // @GET(AuthenticationApiConstants.myProfile)
  // Future<ProfileResponse> getProfile();
}
