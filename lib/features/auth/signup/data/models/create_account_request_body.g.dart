// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_account_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAccountRequestBody _$CreateAccountRequestBodyFromJson(
        Map<String, dynamic> json) =>
    CreateAccountRequestBody(
      email: json['email'] as String,
      password: json['password'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      countryCode: json['country_code'] as String?,
      phoneNumber: json['phone_number'] as String?,
      birthDate: json['birth_date'] as String?,
      gender: json['gender'] as String,
    );

Map<String, dynamic> _$CreateAccountRequestBodyToJson(
        CreateAccountRequestBody instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'country_code': instance.countryCode,
      'phone_number': instance.phoneNumber,
      'birth_date': instance.birthDate,
      'gender': instance.gender,
    };
