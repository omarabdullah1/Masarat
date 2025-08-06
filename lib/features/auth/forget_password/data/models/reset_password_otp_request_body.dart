import 'package:json_annotation/json_annotation.dart';

part 'reset_password_otp_request_body.g.dart';

@JsonSerializable()
class ResetPasswordOtpRequestBody {
  ResetPasswordOtpRequestBody({
    required this.email,
    required this.otp,
    required this.newPassword,
  });

  factory ResetPasswordOtpRequestBody.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordOtpRequestBodyFromJson(json);

  final String email;
  final String otp;
  final String newPassword;

  ResetPasswordOtpRequestBody copyWith({
    String? email,
    String? otp,
    String? newPassword,
  }) {
    return ResetPasswordOtpRequestBody(
      email: email ?? this.email,
      otp: otp ?? this.otp,
      newPassword: newPassword ?? this.newPassword,
    );
  }

  Map<String, dynamic> toJson() => _$ResetPasswordOtpRequestBodyToJson(this);
}