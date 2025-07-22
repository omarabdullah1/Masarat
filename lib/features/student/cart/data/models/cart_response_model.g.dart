// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartResponseModel _$CartResponseModelFromJson(Map<String, dynamic> json) =>
    CartResponseModel(
      id: json['_id'] as String,
      user: json['user'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      version: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$CartResponseModelToJson(CartResponseModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'items': instance.items,
      'totalAmount': instance.totalAmount,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.version,
    };
