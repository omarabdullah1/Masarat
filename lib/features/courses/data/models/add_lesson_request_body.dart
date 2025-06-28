import 'package:json_annotation/json_annotation.dart';

part 'add_lesson_request_body.g.dart';

@JsonSerializable()
class AddLessonRequestBody {
  const AddLessonRequestBody({
    required this.title,
    required this.contentType,
    required this.content,
    required this.courseId,
    required this.order,
    required this.durationEstimate,
    required this.isPreviewable,
  });

  final String title;
  final String contentType;
  final String content;
  final String courseId;
  final int order;
  final String durationEstimate;
  final bool isPreviewable;

  Map<String, dynamic> toJson() => _$AddLessonRequestBodyToJson(this);

  factory AddLessonRequestBody.fromJson(Map<String, dynamic> json) =>
      _$AddLessonRequestBodyFromJson(json);
}
