// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_course_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateCourseResponse _$UpdateCourseResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateCourseResponse(
      id: json['_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      instructor: json['instructor'] as String,
      lessons:
          (json['lessons'] as List<dynamic>).map((e) => e as String).toList(),
      coverImageUrl: json['coverImageUrl'] as String,
      price: (json['price'] as num).toDouble(),
      level: json['level'] as String,
      durationEstimate: json['durationEstimate'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      isPublished: json['isPublished'] as bool,
      verificationStatus: json['verificationStatus'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      v: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$UpdateCourseResponseToJson(
        UpdateCourseResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'category': instance.category,
      'instructor': instance.instructor,
      'lessons': instance.lessons,
      'coverImageUrl': instance.coverImageUrl,
      'price': instance.price,
      'level': instance.level,
      'durationEstimate': instance.durationEstimate,
      'tags': instance.tags,
      'isPublished': instance.isPublished,
      'verificationStatus': instance.verificationStatus,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
    };
