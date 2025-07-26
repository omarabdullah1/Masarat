// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItemModel _$CartItemModelFromJson(Map<String, dynamic> json) =>
    CartItemModel(
      course: CourseCartModel.fromJson(json['course'] as Map<String, dynamic>),
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$CartItemModelToJson(CartItemModel instance) =>
    <String, dynamic>{
      'course': instance.course,
      'price': instance.price,
    };
