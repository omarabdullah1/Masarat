import 'package:json_annotation/json_annotation.dart';

part 'create_course_request_body.g.dart';

@JsonSerializable()
class CreateCourseRequestBody {
  final String title;
  final String description;
  final String category;
  final String level;
  final String durationEstimate;
  final String tags;

  CreateCourseRequestBody({
    required this.title,
    required this.description,
    required this.category,
    required this.level,
    required this.durationEstimate,
    required this.tags,
  });

  factory CreateCourseRequestBody.fromJson(Map<String, dynamic> json) =>
      _$CreateCourseRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCourseRequestBodyToJson(this);
}
