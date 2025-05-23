import 'package:json_annotation/json_annotation.dart';

part 'create_account_request_body.g.dart';

@JsonSerializable()
class CreateAccountRequestBody {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phoneNumber;
  final String? academicDegreePath;
  final String? idNumber;

  CreateAccountRequestBody({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    this.academicDegreePath,
    this.idNumber,
  });

  Map<String, dynamic> toJson() => _$CreateAccountRequestBodyToJson(this);
  factory CreateAccountRequestBody.fromJson(Map<String, dynamic> json) =>
      _$CreateAccountRequestBodyFromJson(json);
}
