// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseCartModel _$CourseCartModelFromJson(Map<String, dynamic> json) =>
    CourseCartModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      instructor: json['instructor'] as String?,
      coverImageUrl: json['coverImageUrl'] as String,
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$CourseCartModelToJson(CourseCartModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'instructor': instance.instructor,
      'coverImageUrl': instance.coverImageUrl,
      'price': instance.price,
    };
