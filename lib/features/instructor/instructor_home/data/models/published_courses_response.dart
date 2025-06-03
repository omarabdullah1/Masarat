import 'package:json_annotation/json_annotation.dart';

import 'course_model.dart';

part 'published_courses_response.g.dart';

@JsonSerializable()
class PublishedCoursesResponse {
  PublishedCoursesResponse({
    required this.courses,
    required this.currentPage,
    required this.totalPages,
    required this.totalCourses,
  });

  factory PublishedCoursesResponse.fromJson(Map<String, dynamic> json) =>
      _$PublishedCoursesResponseFromJson(json);

  final List<CourseModel> courses;
  final int currentPage;
  final int totalPages;
  final int totalCourses;

  Map<String, dynamic> toJson() => _$PublishedCoursesResponseToJson(this);
}
