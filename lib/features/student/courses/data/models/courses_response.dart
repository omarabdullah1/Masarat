import 'package:json_annotation/json_annotation.dart';

import 'course_model.dart';

part 'courses_response.g.dart';

@JsonSerializable()
class CoursesResponse {
  CoursesResponse({
    required this.courses,
    required this.currentPage,
    required this.totalPages,
    required this.totalCourses,
  });

  factory CoursesResponse.fromJson(Map<String, dynamic> json) =>
      _$CoursesResponseFromJson(json);

  final List<CourseModel> courses;
  final int currentPage;
  final int totalPages;
  final int totalCourses;

  Map<String, dynamic> toJson() => _$CoursesResponseToJson(this);
}
