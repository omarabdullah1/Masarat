import 'package:json_annotation/json_annotation.dart';

part 'create_course_response.g.dart';

@JsonSerializable()
class CreateCourseResponse {
  final String title;
  final String description;
  final String category;
  final String instructor;

  @JsonKey(defaultValue: [])
  final List<dynamic> modules;

  final String? coverImageUrl;
  final String level;
  final String durationEstimate;

  @JsonKey(defaultValue: false)
  final bool isPublished;

  @JsonKey(defaultValue: [])
  final List<String> tags;

  @JsonKey(defaultValue: 0)
  final int price;

  @JsonKey(name: '_id')
  final String id;

  final String createdAt;
  final String updatedAt;

  @JsonKey(name: '__v')
  final int v;

  CreateCourseResponse({
    required this.title,
    required this.description,
    required this.category,
    required this.instructor,
    required this.modules,
    this.coverImageUrl,
    required this.level,
    required this.durationEstimate,
    required this.isPublished,
    required this.tags,
    required this.price,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory CreateCourseResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateCourseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCourseResponseToJson(this);
}
