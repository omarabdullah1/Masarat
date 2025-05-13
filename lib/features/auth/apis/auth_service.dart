import 'package:dio/dio.dart';
import 'package:masarat/features/auth/apis/auth_api_constants.dart';
import 'package:masarat/features/auth/login/data/models/login_request_body.dart';
import 'package:masarat/features/auth/login/data/models/login_response.dart';
import 'package:masarat/features/auth/signup/data/models/create_account_request_body.dart';
import 'package:masarat/features/auth/signup/data/models/create_account_response.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_service.g.dart';

// Use empty string for baseUrl, we'll set it in Dio instance
@RestApi()
abstract class AuthenticationService {
  factory AuthenticationService(Dio dio) {
    // Set the base URL from config on the dio instance
    dio.options.baseUrl = AuthenticationApiConstants.apiBaseUrl;
    return _AuthenticationService(dio);
  }

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
