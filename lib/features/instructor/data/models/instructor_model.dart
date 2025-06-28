import 'package:json_annotation/json_annotation.dart';

part 'instructor_model.g.dart';

@JsonSerializable()
class InstructorModel {
  InstructorModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.profilePictureUrl,
  });

  factory InstructorModel.fromJson(Map<String, dynamic> json) =>
      _$InstructorModelFromJson(json);

  @JsonKey(name: '_id')
  final String id;
  final String firstName;
  final String lastName;
  final String? profilePictureUrl;

  Map<String, dynamic> toJson() => _$InstructorModelToJson(this);
}
