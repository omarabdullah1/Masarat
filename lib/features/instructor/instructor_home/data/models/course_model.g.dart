// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseModel _$CourseModelFromJson(Map<String, dynamic> json) => CourseModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category:
          CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
      instructor:
          InstructorModel.fromJson(json['instructor'] as Map<String, dynamic>),
      coverImageUrl: json['coverImageUrl'] as String,
      price: (json['price'] as num).toDouble(),
      level: json['level'] as String,
      durationEstimate: json['durationEstimate'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      isPublished: json['isPublished'] as bool,
      verificationStatus: json['verificationStatus'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CourseModelToJson(CourseModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'category': instance.category,
      'instructor': instance.instructor,
      'coverImageUrl': instance.coverImageUrl,
      'price': instance.price,
      'level': instance.level,
      'durationEstimate': instance.durationEstimate,
      'tags': instance.tags,
      'isPublished': instance.isPublished,
      'verificationStatus': instance.verificationStatus,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
