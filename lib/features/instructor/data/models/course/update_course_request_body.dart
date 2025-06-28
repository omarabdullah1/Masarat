import 'package:json_annotation/json_annotation.dart';

part 'update_course_request_body.g.dart';

@JsonSerializable()
class UpdateCourseRequestBody {
  final String? title;
  final String? description;
  final String? category;
  final String? level;
  final String? durationEstimate;
  final String? tags;
  final double? price;
  final String? verificationStatus;
  final bool? isPublished;

  UpdateCourseRequestBody({
    this.title,
    this.description,
    this.category,
    this.level,
    this.durationEstimate,
    this.tags,
    this.price,
    this.verificationStatus,
    this.isPublished,
  });

  factory UpdateCourseRequestBody.fromJson(Map<String, dynamic> json) =>
      _$UpdateCourseRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateCourseRequestBodyToJson(this);
}
