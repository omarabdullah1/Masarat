import 'package:json_annotation/json_annotation.dart';

import 'course_model.dart';

part 'instructor_courses_response.g.dart';

@JsonSerializable()
class InstructorCoursesResponse {
  InstructorCoursesResponse({
    required this.courses,
    required this.currentPage,
    required this.totalPages,
    required this.totalCourses,
  });

  factory InstructorCoursesResponse.fromJson(Map<String, dynamic> json) =>
      _$InstructorCoursesResponseFromJson(json);

  final List<CourseModel> courses;
  final int currentPage;
  final int totalPages;
  final int totalCourses;

  Map<String, dynamic> toJson() => _$InstructorCoursesResponseToJson(this);
}
