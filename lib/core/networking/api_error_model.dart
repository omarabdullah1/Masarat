import 'package:json_annotation/json_annotation.dart';

part 'api_error_model.g.dart';

@JsonSerializable()
class ApiErrorModel {
  ApiErrorModel({
    this.message,
    this.error,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);
  final String? message;
  final String? error;

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);

  /// Returns a String containing all error messages
  String getAllErrorMessages() {
    if (error != null && error!.isNotEmpty) {
      return error!; // This will return "Password must contain at least one uppercase letter"
    }
    if (message != null && message!.isNotEmpty) {
      return message!;
    }
    return 'Unknown error occurred';
  }
}
