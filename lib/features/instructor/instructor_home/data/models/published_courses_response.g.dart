// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'published_courses_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublishedCoursesResponse _$PublishedCoursesResponseFromJson(
        Map<String, dynamic> json) =>
    PublishedCoursesResponse(
      courses: (json['courses'] as List<dynamic>)
          .map((e) => CourseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPage: (json['currentPage'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      totalCourses: (json['totalCourses'] as num).toInt(),
    );

Map<String, dynamic> _$PublishedCoursesResponseToJson(
        PublishedCoursesResponse instance) =>
    <String, dynamic>{
      'courses': instance.courses,
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'totalCourses': instance.totalCourses,
    };
