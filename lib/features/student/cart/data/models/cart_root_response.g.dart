// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_root_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartRootResponse _$CartRootResponseFromJson(Map<String, dynamic> json) =>
    CartRootResponse(
      success: json['success'] as bool,
      data: CartResponseModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartRootResponseToJson(CartRootResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
