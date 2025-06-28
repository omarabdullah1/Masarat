import 'package:json_annotation/json_annotation.dart';

part 'lesson_model.g.dart';

@JsonSerializable()
class LessonModel {
  LessonModel({
    required this.id,
    required this.title,
    required this.contentType,
    required this.order,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) =>
      _$LessonModelFromJson(json);

  @JsonKey(name: '_id')
  final String id;
  final String title;
  final String contentType;
  final int order;

  Map<String, dynamic> toJson() => _$LessonModelToJson(this);
}
