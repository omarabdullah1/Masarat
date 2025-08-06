import 'package:json_annotation/json_annotation.dart';

part 'success_response.g.dart';

@JsonSerializable()
class SuccessResponse {
  SuccessResponse({
    required this.message,
  });

  factory SuccessResponse.fromJson(Map<String, dynamic> json) =>
      _$SuccessResponseFromJson(json);

  final String message;

  Map<String, dynamic> toJson() => _$SuccessResponseToJson(this);
}