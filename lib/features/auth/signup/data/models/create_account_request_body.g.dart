// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_account_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAccountRequestBody _$CreateAccountRequestBodyFromJson(
        Map<String, dynamic> json) =>
    CreateAccountRequestBody(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      phoneNumber: json['phoneNumber'] as String,
      academicDegreePath: json['academicDegreePath'] as String?,
      idNumber: json['idNumber'] as String?,
    );

Map<String, dynamic> _$CreateAccountRequestBodyToJson(
        CreateAccountRequestBody instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'password': instance.password,
      'phoneNumber': instance.phoneNumber,
      'academicDegreePath': instance.academicDegreePath,
      'idNumber': instance.idNumber,
    };
