import 'package:json_annotation/json_annotation.dart';

import 'category_model.dart';

part 'course_model.g.dart';

@JsonSerializable()
class CourseModel {
  CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.instructor,
    required this.coverImageUrl,
    required this.price,
    required this.level,
    required this.durationEstimate,
    required this.tags,
    required this.isPublished,
    required this.verificationStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);

  @JsonKey(name: '_id')
  final String id;
  final String title;
  final String description;
  final CategoryModel category;
  final String instructor;
  final String coverImageUrl;
  final double price;
  final String level;
  final String durationEstimate;
  final List<String> tags;
  final bool isPublished;
  final String verificationStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() => _$CourseModelToJson(this);
}
