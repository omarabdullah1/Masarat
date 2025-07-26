import 'dart:io';

import 'package:dio/dio.dart';
import 'package:masarat/features/instructor/profile/data/apis/instructor_profile_service.dart';
import 'package:masarat/features/instructor/profile/data/models/instructor_profile_response.dart';

class InstructorProfileRepository {
  final InstructorProfileService _profileService;

  InstructorProfileRepository(this._profileService);

  Future<InstructorProfileResponse> getProfile() async {
    final response = await _profileService.getProfile();
    if (response is Map<String, dynamic>) {
      return InstructorProfileResponse.fromJson(response);
    }
    throw Exception('Invalid response format');
  }

  Future<InstructorProfileResponse> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
    String? contactNumber,
    String? nationality,
    String? countryOfResidence,
    String? governorate,
    String? academicDegree,
    String? specialty,
    String? jobTitle,
    String? workEntity,
    File? profilePicture,
  }) async {
    final formData = FormData.fromMap({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      if (contactNumber != null) 'contactNumber': contactNumber,
      if (nationality != null) 'nationality': nationality,
      if (countryOfResidence != null) 'countryOfResidence': countryOfResidence,
      if (governorate != null) 'governorate': governorate,
      if (academicDegree != null) 'academicDegree': academicDegree,
      if (specialty != null) 'specialty': specialty,
      if (jobTitle != null) 'jobTitle': jobTitle,
      if (workEntity != null) 'workEntity': workEntity,
      if (profilePicture != null)
        'profilePicture': await MultipartFile.fromFile(profilePicture.path,
            filename: profilePicture.path.split('/').last),
    });
    final response = await _profileService.updateProfile(formData);
    if (response is Map<String, dynamic> &&
        response['user'] is Map<String, dynamic>) {
      return InstructorProfileResponse.fromJson(response['user']);
    }
    throw Exception('Invalid response format');
  }
}
