// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonModel _$LessonModelFromJson(Map<String, dynamic> json) => LessonModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      contentType: json['contentType'] as String,
      order: (json['order'] as num).toInt(),
    );

Map<String, dynamic> _$LessonModelToJson(LessonModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'contentType': instance.contentType,
      'order': instance.order,
    };
