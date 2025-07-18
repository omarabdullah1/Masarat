// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_lesson_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddLessonResponse _$AddLessonResponseFromJson(Map<String, dynamic> json) =>
    AddLessonResponse(
      id: json['_id'] as String,
      title: json['title'] as String,
      contentType: json['contentType'] as String,
      content: json['content'] as String,
      course: json['course'] as String,
      order: (json['order'] as num).toInt(),
      durationEstimate:
          AddLessonResponse._durationEstimateFromJson(json['durationEstimate']),
      isPreviewable: json['isPreviewable'] as bool,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      v: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$AddLessonResponseToJson(AddLessonResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'contentType': instance.contentType,
      'content': instance.content,
      'course': instance.course,
      'order': instance.order,
      'durationEstimate': instance.durationEstimate,
      'isPreviewable': instance.isPreviewable,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
    };
