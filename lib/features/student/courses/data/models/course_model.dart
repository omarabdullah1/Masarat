import 'package:json_annotation/json_annotation.dart';

import 'category_model.dart';
import 'instructor_model.dart';
import 'lesson_model.dart';

part 'course_model.g.dart';

@JsonSerializable()
class CourseModel {
  CourseModel({
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
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);

  @JsonKey(name: '_id')
  final String id;
  final String title;
  final String description;
  final CategoryModel category;
  final InstructorModel instructor;
  final List<LessonModel> lessons;
  final String coverImageUrl;
  final int price;
  final String level;
  final String durationEstimate;
  final List<String> tags;
  final bool isPublished;
  final String verificationStatus;
  final String createdAt;
  final String updatedAt;

  Map<String, dynamic> toJson() => _$CourseModelToJson(this);
}
