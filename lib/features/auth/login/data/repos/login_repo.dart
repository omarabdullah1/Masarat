import 'dart:developer';

import 'package:masarat/core/networking/api_error_handler.dart';
import 'package:masarat/core/networking/api_result.dart';
import 'package:masarat/features/auth/apis/auth_service.dart';
import 'package:masarat/features/auth/login/data/models/login_request_body.dart';
import 'package:masarat/features/auth/login/data/models/login_response.dart';

class LoginRepo {
  LoginRepo(this._apiService);
  final AuthenticationService _apiService;

  Future<ApiResult<LoginResponse>> login(
    LoginRequestBody loginRequestBody,
  ) async {
    try {
      final response = await _apiService.login(loginRequestBody);
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      log('Login error: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
