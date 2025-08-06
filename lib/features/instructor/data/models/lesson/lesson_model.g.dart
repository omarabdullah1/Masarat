// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonModel _$LessonModelFromJson(Map<String, dynamic> json) => LessonModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      contentType: json['contentType'] as String,
      content: json['content'] as String?,
      order: (json['order'] as num).toInt(),
      durationEstimate:
          LessonModel._durationEstimateFromJson(json['durationEstimate']),
      isPreviewable: json['isPreviewable'] as bool,
    );

Map<String, dynamic> _$LessonModelToJson(LessonModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'contentType': instance.contentType,
      'content': instance.content,
      'order': instance.order,
      'durationEstimate': instance.durationEstimate,
      'isPreviewable': instance.isPreviewable,
    };
