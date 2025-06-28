import 'package:json_annotation/json_annotation.dart';

part 'update_course_response.g.dart';

@JsonSerializable()
class UpdateCourseResponse {
  @JsonKey(name: '_id')
  final String id;
  final String title;
  final String description;
  final String category;
  final String instructor;
  final List<String> lessons;
  final String coverImageUrl;
  final double price;
  final String level;
  final String durationEstimate;
  final List<String> tags;
  final bool isPublished;
  final String verificationStatus;
  final String createdAt;
  final String updatedAt;
  @JsonKey(name: '__v')
  final int v;

  UpdateCourseResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.instructor,
    required this.lessons,
    required this.coverImageUrl,
    required this.price,
    required this.level,
    required this.durationEstimate,
    required this.tags,
    required this.isPublished,
    required this.verificationStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory UpdateCourseResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateCourseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateCourseResponseToJson(this);
}
