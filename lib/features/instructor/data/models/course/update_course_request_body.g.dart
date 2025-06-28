// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_course_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateCourseRequestBody _$UpdateCourseRequestBodyFromJson(
        Map<String, dynamic> json) =>
    UpdateCourseRequestBody(
      title: json['title'] as String?,
      description: json['description'] as String?,
      category: json['category'] as String?,
      level: json['level'] as String?,
      durationEstimate: json['durationEstimate'] as String?,
      tags: json['tags'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      verificationStatus: json['verificationStatus'] as String?,
      isPublished: json['isPublished'] as bool?,
    );

Map<String, dynamic> _$UpdateCourseRequestBodyToJson(
        UpdateCourseRequestBody instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'category': instance.category,
      'level': instance.level,
      'durationEstimate': instance.durationEstimate,
      'tags': instance.tags,
      'price': instance.price,
      'verificationStatus': instance.verificationStatus,
      'isPublished': instance.isPublished,
    };
