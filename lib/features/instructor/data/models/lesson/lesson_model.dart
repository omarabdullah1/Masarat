import 'package:json_annotation/json_annotation.dart';

part 'lesson_model.g.dart';

@JsonSerializable()
class LessonModel {
  const LessonModel({
    required this.id,
    required this.title,
    required this.contentType,
    required this.content,
    required this.order,
    required this.durationEstimate,
    required this.isPreviewable,
  });

  @JsonKey(name: '_id')
  final String id;
  final String title;
  final String contentType;
  final String content;
  final int order;
  @JsonKey(fromJson: _durationEstimateFromJson)
  final String durationEstimate;
  final bool isPreviewable;

  // Custom converter for durationEstimate that can handle both String and int
  static String _durationEstimateFromJson(dynamic value) {
    if (value is int) {
      return value.toString();
    } else if (value is String) {
      return value;
    }
    return '';
  }

  Map<String, dynamic> toJson() => _$LessonModelToJson(this);

  factory LessonModel.fromJson(Map<String, dynamic> json) =>
      _$LessonModelFromJson(json);
}
