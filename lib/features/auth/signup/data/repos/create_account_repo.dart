import 'dart:io';

import 'package:masarat/core/networking/api_error_handler.dart';
import 'package:masarat/core/networking/api_result.dart';
import 'package:masarat/features/auth/apis/auth_service.dart';
import 'package:masarat/features/auth/signup/data/models/create_account_request_body.dart';
import 'package:masarat/features/auth/signup/data/models/create_account_response.dart';

class CreateAccountRepo {
  CreateAccountRepo(this._apiService);
  final AuthenticationService _apiService;

  Future<ApiResult<CreateAccountResponse>> createAccount(
    CreateAccountRequestBody createAccountRequestBody,
  ) async {
    try {
      // Upload academic degree file if provided
      if (createAccountRequestBody.academicDegreePath != null) {
        final uploadResult = await uploadAcademicDegree(
            File(createAccountRequestBody.academicDegreePath!));
        if (uploadResult is ApiResultFailure) {
          return ApiResult.failure(uploadResult.error);
        }
      }

      // Create account
      final response =
          await _apiService.createAccount(createAccountRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<dynamic>> uploadAcademicDegree(File file) async {
    try {
      final response = await _apiService.uploadAcademicDegree(file);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
