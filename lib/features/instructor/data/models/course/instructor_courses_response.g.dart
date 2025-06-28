// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instructor_courses_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstructorCoursesResponse _$InstructorCoursesResponseFromJson(
        Map<String, dynamic> json) =>
    InstructorCoursesResponse(
      courses: (json['courses'] as List<dynamic>)
          .map((e) => CourseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPage: (json['currentPage'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      totalCourses: (json['totalCourses'] as num).toInt(),
    );

Map<String, dynamic> _$InstructorCoursesResponseToJson(
        InstructorCoursesResponse instance) =>
    <String, dynamic>{
      'courses': instance.courses,
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'totalCourses': instance.totalCourses,
    };
