// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_lesson_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddLessonRequestBody _$AddLessonRequestBodyFromJson(
        Map<String, dynamic> json) =>
    AddLessonRequestBody(
      title: json['title'] as String,
      contentType: json['contentType'] as String,
      content: json['content'] as String,
      courseId: json['courseId'] as String,
      order: (json['order'] as num).toInt(),
      durationEstimate: json['durationEstimate'] as String,
      isPreviewable: json['isPreviewable'] as bool,
    );

Map<String, dynamic> _$AddLessonRequestBodyToJson(
        AddLessonRequestBody instance) =>
    <String, dynamic>{
      'title': instance.title,
      'contentType': instance.contentType,
      'content': instance.content,
      'courseId': instance.courseId,
      'order': instance.order,
      'durationEstimate': instance.durationEstimate,
      'isPreviewable': instance.isPreviewable,
    };
