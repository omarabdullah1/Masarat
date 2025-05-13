import 'package:json_annotation/json_annotation.dart';

part 'create_account_request_body.g.dart';

@JsonSerializable()
class CreateAccountRequestBody {
  final String email;
  final String password;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'country_code')
  final String? countryCode;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @JsonKey(name: 'birth_date')
  final String? birthDate;
  final String gender;

  CreateAccountRequestBody({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    this.countryCode,
    this.phoneNumber,
    this.birthDate,
    required this.gender,
  });

  Map<String, dynamic> toJson() => _$CreateAccountRequestBodyToJson(this);
  factory CreateAccountRequestBody.fromJson(Map<String, dynamic> json) =>
      _$CreateAccountRequestBodyFromJson(json);
}
