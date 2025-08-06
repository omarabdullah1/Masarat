import 'package:json_annotation/json_annotation.dart';

part 'send_otp_request_body.g.dart';

@JsonSerializable()
class SendOtpRequestBody {
  SendOtpRequestBody({
    required this.email,
    required this.type,
  });

  factory SendOtpRequestBody.fromJson(Map<String, dynamic> json) =>
      _$SendOtpRequestBodyFromJson(json);

  final String email;
  final String type;

  Map<String, dynamic> toJson() => _$SendOtpRequestBodyToJson(this);
}