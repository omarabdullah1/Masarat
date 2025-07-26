// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentProfileResponse _$StudentProfileResponseFromJson(
        Map<String, dynamic> json) =>
    StudentProfileResponse(
      id: json['id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      role: json['role'] as String?,
      enrolledCourses: json['enrolledCourses'] as List<dynamic>?,
      certificates: json['certificates'] as List<dynamic>?,
      isVerified: json['isVerified'] as bool?,
      isInstructorVerified: json['isInstructorVerified'] as bool?,
      instructorApplicationStatus:
          json['instructorApplicationStatus'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: (json['v'] as num?)?.toInt(),
      settings: json['settings'] == null
          ? null
          : StudentProfileSettings.fromJson(
              json['settings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StudentProfileResponseToJson(
        StudentProfileResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'role': instance.role,
      'enrolledCourses': instance.enrolledCourses,
      'certificates': instance.certificates,
      'isVerified': instance.isVerified,
      'isInstructorVerified': instance.isInstructorVerified,
      'instructorApplicationStatus': instance.instructorApplicationStatus,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'v': instance.v,
      'settings': instance.settings,
    };

StudentProfileSettings _$StudentProfileSettingsFromJson(
        Map<String, dynamic> json) =>
    StudentProfileSettings(
      language: json['language'] as String?,
    );

Map<String, dynamic> _$StudentProfileSettingsToJson(
        StudentProfileSettings instance) =>
    <String, dynamic>{
      'language': instance.language,
    };
