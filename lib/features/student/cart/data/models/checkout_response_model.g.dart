// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckoutResponseModel _$CheckoutResponseModelFromJson(
        Map<String, dynamic> json) =>
    CheckoutResponseModel(
      success: json['success'] as bool,
      redirectUrl: json['redirectUrl'] as String,
      orderId: json['orderId'] as String,
    );

Map<String, dynamic> _$CheckoutResponseModelToJson(
        CheckoutResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'redirectUrl': instance.redirectUrl,
      'orderId': instance.orderId,
    };

CheckoutRootResponse _$CheckoutRootResponseFromJson(
        Map<String, dynamic> json) =>
    CheckoutRootResponse(
      success: json['success'] as bool,
      redirectUrl: json['redirectUrl'] as String,
      orderId: json['orderId'] as String,
    );
