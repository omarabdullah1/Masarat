import 'package:json_annotation/json_annotation.dart';

part 'add_lesson_response.g.dart';

@JsonSerializable()
class AddLessonResponse {
  const AddLessonResponse({
    required this.id,
    required this.title,
    required this.contentType,
    required this.content,
    required this.course,
    required this.order,
    required this.durationEstimate,
    required this.isPreviewable,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  @JsonKey(name: '_id')
  final String id;
  final String title;
  final String contentType;
  final String content;
  final String course;
  final int order;
  final String durationEstimate;
  final bool isPreviewable;
  final String createdAt;
  final String updatedAt;
  @JsonKey(name: '__v')
  final int v;

  Map<String, dynamic> toJson() => _$AddLessonResponseToJson(this);

  factory AddLessonResponse.fromJson(Map<String, dynamic> json) =>
      _$AddLessonResponseFromJson(json);
}
