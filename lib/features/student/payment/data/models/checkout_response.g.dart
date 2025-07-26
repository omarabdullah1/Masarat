// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckoutResponse _$CheckoutResponseFromJson(Map<String, dynamic> json) =>
    CheckoutResponse(
      success: json['success'] as bool,
      redirectUrl: json['redirectUrl'] as String,
      orderId: json['orderId'] as String,
    );

Map<String, dynamic> _$CheckoutResponseToJson(CheckoutResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'redirectUrl': instance.redirectUrl,
      'orderId': instance.orderId,
    };
