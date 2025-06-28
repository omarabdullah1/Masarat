// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instructor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstructorModel _$InstructorModelFromJson(Map<String, dynamic> json) =>
    InstructorModel(
      id: json['_id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
    );

Map<String, dynamic> _$InstructorModelToJson(InstructorModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
    };
