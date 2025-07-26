// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instructor_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstructorProfileResponse _$InstructorProfileResponseFromJson(
        Map<String, dynamic> json) =>
    InstructorProfileResponse(
      id: json['id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      role: json['role'] as String?,
      courses: json['courses'] as List<dynamic>?,
      isVerified: json['isVerified'] as bool?,
      isInstructorVerified: json['isInstructorVerified'] as bool?,
      instructorApplicationStatus:
          json['instructorApplicationStatus'] as String?,
      contactNumber: json['contactNumber'] as String?,
      nationalIdImageUrl: json['nationalIdImageUrl'] as String?,
      nationality: json['nationality'] as String?,
      countryOfResidence: json['countryOfResidence'] as String?,
      governorate: json['governorate'] as String?,
      academicDegree: json['academicDegree'] as String?,
      specialty: json['specialty'] as String?,
      jobTitle: json['jobTitle'] as String?,
      workEntity: json['workEntity'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: (json['v'] as num?)?.toInt(),
      settings: json['settings'] == null
          ? null
          : InstructorProfileSettings.fromJson(
              json['settings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InstructorProfileResponseToJson(
        InstructorProfileResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'role': instance.role,
      'courses': instance.courses,
      'isVerified': instance.isVerified,
      'isInstructorVerified': instance.isInstructorVerified,
      'instructorApplicationStatus': instance.instructorApplicationStatus,
      'contactNumber': instance.contactNumber,
      'nationalIdImageUrl': instance.nationalIdImageUrl,
      'nationality': instance.nationality,
      'countryOfResidence': instance.countryOfResidence,
      'governorate': instance.governorate,
      'academicDegree': instance.academicDegree,
      'specialty': instance.specialty,
      'jobTitle': instance.jobTitle,
      'workEntity': instance.workEntity,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'v': instance.v,
      'settings': instance.settings,
    };

InstructorProfileSettings _$InstructorProfileSettingsFromJson(
        Map<String, dynamic> json) =>
    InstructorProfileSettings(
      language: json['language'] as String?,
    );

Map<String, dynamic> _$InstructorProfileSettingsToJson(
        InstructorProfileSettings instance) =>
    <String, dynamic>{
      'language': instance.language,
    };
