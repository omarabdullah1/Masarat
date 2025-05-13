import 'package:json_annotation/json_annotation.dart';

part 'create_account_response.g.dart';

@JsonSerializable()
class CreateAccountResponse {
  String? message;
  String? error; // Added error field to handle API error responses

  CreateAccountResponse({
    this.message,
    this.error,
  });

  factory CreateAccountResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateAccountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAccountResponseToJson(this);
}
