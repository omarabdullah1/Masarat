import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:masarat/core/networking/api_error_handler.dart';
import 'package:masarat/core/networking/api_error_model.dart';
import 'package:masarat/core/networking/api_result.dart';
import 'package:masarat/features/auth/apis/auth_service.dart';
import 'package:masarat/features/auth/signup/data/models/create_account_request_body.dart';
import 'package:masarat/features/auth/signup/data/models/create_account_response.dart';

class CreateAccountRepo {
  CreateAccountRepo(this._apiService);
  final AuthenticationService _apiService;

  Future<ApiResult<CreateAccountResponse>>
      _trySimplifiedInstructorRegistration({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phoneNumber,
    required String nationality,
    required String countryOfResidence,
    required String governorate,
    required String academicDegree,
    required String specialty,
    required String jobTitle,
    required String workEntity,
    required String idNumber,
    required File nationalIdFile,
  }) async {
    log('Attempting to use a simpler approach for instructor registration');

    final formDataSimple = FormData();

    // Add all required text fields with correct API field names
    formDataSimple.fields.add(MapEntry('firstName', firstName));
    formDataSimple.fields.add(MapEntry('lastName', lastName));
    formDataSimple.fields.add(MapEntry('email', email));
    formDataSimple.fields.add(MapEntry('password', password));
    formDataSimple.fields.add(MapEntry('contactNumber', phoneNumber));
    formDataSimple.fields.add(MapEntry('nationality', nationality));
    formDataSimple.fields
        .add(MapEntry('countryOfResidence', countryOfResidence));
    formDataSimple.fields.add(MapEntry('governorate', governorate));
    formDataSimple.fields.add(MapEntry('academicDegree', academicDegree));
    formDataSimple.fields.add(MapEntry('specialty', specialty));
    formDataSimple.fields.add(MapEntry('jobTitle', jobTitle));
    formDataSimple.fields.add(MapEntry('workEntity', workEntity));
    formDataSimple.fields.add(MapEntry('idNumber', idNumber));

    log('Sending instructor registration data: ${formDataSimple.fields.map((e) => '${e.key}: ${e.value}').join(', ')}');

    // Add the file with the correct field name
    final filename = nationalIdFile.path.split(Platform.pathSeparator).last;
    log('Using academic degree file as National ID image: ${nationalIdFile.path}');
    final fileSize = await nationalIdFile.length();
    final fileSizeKB = fileSize / 1024;
    log('National ID image file size: ${fileSizeKB.toStringAsFixed(2)} KB');

    formDataSimple.files.add(MapEntry(
      'nationalIdImage',
      await MultipartFile.fromFile(
        nationalIdFile.path,
        filename: filename,
        contentType: MediaType.parse('image/jpeg'),
      ),
    ));
    log('With files: nationalIdImage:$filename');

    final Dio dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(minutes: 5),
      sendTimeout: const Duration(minutes: 5),
    ));

    // Try a more direct approach with clearer URL
    const String url =
        'https://wecareroot.ddns.net:5300/api/v1/auth/register-instructor';

    log('Attempting instructor registration with simplified approach');
    log('Using URL: $url');
    log('Starting upload at ${DateTime.now().toIso8601String()}');

    try {
      // Detailed logging
      log('*** Request ***');
      log('uri: $url');
      log('method: POST');
      log('responseType: ${dio.options.responseType}');
      log('followRedirects: ${dio.options.followRedirects}');
      log('persistentConnection: ${dio.options.persistentConnection}');
      log('connectTimeout: ${dio.options.connectTimeout}');
      log('sendTimeout: ${dio.options.sendTimeout}');
      log('receiveTimeout: ${dio.options.receiveTimeout}');
      log('receiveDataWhenStatusError: ${dio.options.receiveDataWhenStatusError}');
      log('extra: ${dio.options.extra}');
      log('headers:');
      log(' content-type: multipart/form-data');
      log('data:');
      log('$formDataSimple');
      log('');

      // Track progress
      int lastProgress = -1;

      final response = await dio.post(url,
          data: formDataSimple,
          options: Options(
            headers: {
              'Accept': 'application/json',
            },
            contentType: 'multipart/form-data',
            validateStatus: (status) => status! < 500,
          ), onSendProgress: (sent, total) {
        final progress = (sent / total * 100).floor();
        if (progress != lastProgress) {
          lastProgress = progress;
          log('Upload progress: $progress%');
        }
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Instructor registration successful!');
        log('Response data: ${response.data}');
        return ApiResult.success(CreateAccountResponse.fromJson(response.data));
      } else {
        log('Server returned error status: ${response.statusCode}');
        log('Error response: ${response.data}');

        String errorMessage = 'Unknown error occurred';
        if (response.data is Map && response.data['message'] != null) {
          errorMessage = response.data['message'];
        }

        return ApiResult.failure(ApiErrorModel(message: errorMessage));
      }
    } catch (e) {
      if (e is DioException) {
        log('Simplified approach failed with DioException: ${e.type}');
        log('DioException message: ${e.message}');
        if (e.response != null) {
          log('Status code: ${e.response?.statusCode}');
          log('Response data: ${e.response?.data}');
        }

        // More detailed error message for debugging
        if (e.type == DioExceptionType.connectionTimeout) {
          return ApiResult.failure(ApiErrorModel(
              message:
                  'Connection timeout. Please check your internet connection.'));
        } else if (e.type == DioExceptionType.sendTimeout) {
          return ApiResult.failure(ApiErrorModel(
              message:
                  'Upload timeout. The file may be too large or the connection too slow.'));
        } else if (e.type == DioExceptionType.receiveTimeout) {
          return ApiResult.failure(
              ApiErrorModel(message: 'Server took too long to respond.'));
        } else if (e.type == DioExceptionType.badResponse) {
          final message =
              e.response?.data?['message'] ?? 'Server returned an error';
          return ApiResult.failure(ApiErrorModel(message: message));
        }
      }

      log('Simplified approach failed: $e');
      return ApiResult.failure(ApiErrorModel(
          message: 'Registration failed. Please try again later.'));
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

  Future<ApiResult<CreateAccountResponse>> createAccount({
    required CreateAccountRequestBody createAccountRequestBody,
    required bool isInstructor,
    File? nationalIdFile,
    String? nationality,
    String? countryOfResidence,
    String? governorate,
    String? academicDegree,
    String? specialty,
    String? jobTitle,
    String? workEntity,
  }) async {
    try {
      log('Registration API request: ${createAccountRequestBody.toJson()}');

      if (isInstructor && nationalIdFile != null) {
        // Use the instructor registration path with file upload
        return await _trySimplifiedInstructorRegistration(
          firstName: createAccountRequestBody.firstName,
          lastName: createAccountRequestBody.lastName,
          email: createAccountRequestBody.email,
          password: createAccountRequestBody.password,
          phoneNumber: createAccountRequestBody.phoneNumber,
          nationality: nationality ?? 'Egyptian',
          countryOfResidence: countryOfResidence ?? 'Egypt',
          governorate: governorate ?? 'Cairo',
          academicDegree: academicDegree ??
              createAccountRequestBody.academicDegreePath ??
              '',
          specialty: specialty ?? 'Not specified',
          jobTitle: jobTitle ?? 'Not specified',
          workEntity: workEntity ?? 'Not specified',
          idNumber: createAccountRequestBody.idNumber ?? '',
          nationalIdFile: nationalIdFile,
        );
      } else {
        // Use the standard student registration
        log('Using standard registration endpoint for student');
        final response =
            await _apiService.createAccount(createAccountRequestBody);
        log('Registration API response: ApiResult<CreateAccountResponse>.success(data: $response)');
        return ApiResult.success(response);
      }
    } catch (e) {
      log('Registration API response: ApiResult<CreateAccountResponse>.failure(apiErrorModel: Instance of \'ApiErrorModel\')');
      log('Registration failure: ${ApiErrorHandler.handle(e).message}');
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
