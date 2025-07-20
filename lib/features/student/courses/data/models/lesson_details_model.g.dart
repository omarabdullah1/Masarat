// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonDetailsModel _$LessonDetailsModelFromJson(Map<String, dynamic> json) =>
    LessonDetailsModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      content: json['content'] as String?,
      contentType: json['contentType'] as String?,
      order: (json['order'] as num?)?.toInt(),
      durationEstimate: json['durationEstimate'] as String?,
      isPreviewable: json['isPreviewable'] as bool? ?? false,
      videoId: json['videoId'] as String?,
      videoLibraryId: json['videoLibraryId'] as String?,
    );

Map<String, dynamic> _$LessonDetailsModelToJson(LessonDetailsModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'contentType': instance.contentType,
      'order': instance.order,
      'durationEstimate': instance.durationEstimate,
      'isPreviewable': instance.isPreviewable,
      'videoId': instance.videoId,
      'videoLibraryId': instance.videoLibraryId,
    };
