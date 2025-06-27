import 'package:json_annotation/json_annotation.dart';

part 'create_account_response.g.dart';

@JsonSerializable()
class CreateAccountResponse {
  String? message;

  CreateAccountResponse({
    this.message,
  });

  factory CreateAccountResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateAccountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAccountResponseToJson(this);
}
