// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_course_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCourseRequestBody _$CreateCourseRequestBodyFromJson(
        Map<String, dynamic> json) =>
    CreateCourseRequestBody(
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      level: json['level'] as String,
      durationEstimate: json['durationEstimate'] as String,
      tags: json['tags'] as String,
    );

Map<String, dynamic> _$CreateCourseRequestBodyToJson(
        CreateCourseRequestBody instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'category': instance.category,
      'level': instance.level,
      'durationEstimate': instance.durationEstimate,
      'tags': instance.tags,
    };
