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
      final response =
          await _apiService.createAccount(createAccountRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
