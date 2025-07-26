import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:masarat/features/student/profile/data/apis/student_profile_service.dart';
import 'package:masarat/features/student/profile/data/models/student_profile_response.dart';

class StudentProfileRepository {
  final StudentProfileService _profileService;
  final Dio _dio;

  StudentProfileRepository(this._profileService, this._dio);

  Future<StudentProfileResponse> getProfile() async {
    final response = await _profileService.getProfile();
    if (response is Map<String, dynamic>) {
      return StudentProfileResponse.fromJson(response);
    }
    throw Exception('Invalid response format');
  }

  Future<StudentProfileResponse> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
    String? phone,
    File? profileImage,
    void Function(int, int)? onSendProgress,
  }) async {
    final data = <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'settings': '{"language":"ar"}',
    };
    if (phone != null) {
      data['phoneNumber'] = phone;
    }
    if (profileImage != null) {
      data['profilePicture'] = await MultipartFile.fromFile(profileImage.path,
          filename: profileImage.path.split('/').last);
    }
    final formData = FormData.fromMap(data);

    // Debug logs
    log('--- StudentProfileRepository.updateProfile DEBUG ---');
    log('Dio baseUrl: \'${_dio.options.baseUrl}\'');
    log('PUT URL: \'${_dio.options.baseUrl}/api/v1/users/me\'');
    log('FormData fields:');
    for (var field in formData.fields) {
      log('  ${field.key}: ${field.value}');
    }
    log('FormData files:');
    for (var file in formData.files) {
      log('  ${file.key}: ${file.value.filename}');
    }

    final response = await _dio.put(
      '/api/v1/users/me',
      data: formData,
      onSendProgress: onSendProgress,
      options: Options(contentType: 'multipart/form-data'),
    );
    if (response.data is Map<String, dynamic>) {
      return StudentProfileResponse.fromJson(response.data);
    }
    throw Exception('Invalid response format');
  }
}
