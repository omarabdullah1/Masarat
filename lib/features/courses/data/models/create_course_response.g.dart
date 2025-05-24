// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_course_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCourseResponse _$CreateCourseResponseFromJson(
        Map<String, dynamic> json) =>
    CreateCourseResponse(
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      instructor: json['instructor'] as String,
      modules: json['modules'] as List<dynamic>? ?? [],
      coverImageUrl: json['coverImageUrl'] as String?,
      level: json['level'] as String,
      durationEstimate: json['durationEstimate'] as String,
      isPublished: json['isPublished'] as bool? ?? false,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      price: (json['price'] as num?)?.toInt() ?? 0,
      id: json['_id'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      v: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$CreateCourseResponseToJson(
        CreateCourseResponse instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'category': instance.category,
      'instructor': instance.instructor,
      'modules': instance.modules,
      'coverImageUrl': instance.coverImageUrl,
      'level': instance.level,
      'durationEstimate': instance.durationEstimate,
      'isPublished': instance.isPublished,
      'tags': instance.tags,
      'price': instance.price,
      '_id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
    };
