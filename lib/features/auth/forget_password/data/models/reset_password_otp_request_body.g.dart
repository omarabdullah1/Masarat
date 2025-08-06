// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_otp_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPasswordOtpRequestBody _$ResetPasswordOtpRequestBodyFromJson(
        Map<String, dynamic> json) =>
    ResetPasswordOtpRequestBody(
      email: json['email'] as String,
      otp: json['otp'] as String,
      newPassword: json['newPassword'] as String,
    );

Map<String, dynamic> _$ResetPasswordOtpRequestBodyToJson(
        ResetPasswordOtpRequestBody instance) =>
    <String, dynamic>{
      'email': instance.email,
      'otp': instance.otp,
      'newPassword': instance.newPassword,
    };
