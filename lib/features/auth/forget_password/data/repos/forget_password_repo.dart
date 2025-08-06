import 'dart:developer';

import 'package:masarat/core/networking/api_error_handler.dart';
import 'package:masarat/core/networking/api_result.dart';
import 'package:masarat/features/auth/apis/auth_service.dart';
import 'package:masarat/features/auth/forget_password/data/models/reset_password_otp_request_body.dart';
import 'package:masarat/features/auth/forget_password/data/models/send_otp_request_body.dart';

class ForgetPasswordRepo {
  ForgetPasswordRepo(this._apiService);
  final AuthenticationService _apiService;

  Future<ApiResult<String>> sendOtp(
    SendOtpRequestBody sendOtpRequestBody,
  ) async {
    try {
      final response = await _apiService.sendOtp(sendOtpRequestBody);
      return ApiResult.success(response.message);
    } catch (error, stackTrace) {
      log('Send OTP error: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<String>> resetPasswordWithOtp(
    ResetPasswordOtpRequestBody resetPasswordOtpRequestBody,
  ) async {
    try {
      final response = await _apiService.resetPasswordWithOtp(
        resetPasswordOtpRequestBody,
      );
      return ApiResult.success(response.message);
    } catch (error, stackTrace) {
      log('Reset password error: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
