// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_instructor_account_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateInstructorAccountRequestBody _$CreateInstructorAccountRequestBodyFromJson(
        Map<String, dynamic> json) =>
    CreateInstructorAccountRequestBody(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      phoneNumber: json['phoneNumber'] as String,
      academicDegreePath: json['academicDegreePath'] as String?,
      idNumber: json['idNumber'] as String?,
      nationality: json['nationality'] as String,
      countryOfResidence: json['countryOfResidence'] as String,
      governorate: json['governorate'] as String,
      academicDegree: json['academicDegree'] as String,
      specialty: json['specialty'] as String,
      jobTitle: json['jobTitle'] as String,
      workEntity: json['workEntity'] as String,
      nationalIdImage: json['nationalIdImage'] as String?,
    );

Map<String, dynamic> _$CreateInstructorAccountRequestBodyToJson(
        CreateInstructorAccountRequestBody instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'password': instance.password,
      'phoneNumber': instance.phoneNumber,
      'academicDegreePath': instance.academicDegreePath,
      'idNumber': instance.idNumber,
      'nationality': instance.nationality,
      'countryOfResidence': instance.countryOfResidence,
      'governorate': instance.governorate,
      'academicDegree': instance.academicDegree,
      'specialty': instance.specialty,
      'jobTitle': instance.jobTitle,
      'workEntity': instance.workEntity,
      'nationalIdImage': instance.nationalIdImage,
    };
