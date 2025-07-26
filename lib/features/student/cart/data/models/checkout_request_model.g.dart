// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckoutRequestModel _$CheckoutRequestModelFromJson(
        Map<String, dynamic> json) =>
    CheckoutRequestModel(
      sourceId:
          SourceIdModel.fromJson(json['sourceId'] as Map<String, dynamic>),
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$CheckoutRequestModelToJson(
        CheckoutRequestModel instance) =>
    <String, dynamic>{
      'sourceId': instance.sourceId,
      'currency': instance.currency,
    };

SourceIdModel _$SourceIdModelFromJson(Map<String, dynamic> json) =>
    SourceIdModel(
      id: json['id'] as String,
      phone: json['phone'] == null
          ? null
          : PhoneModel.fromJson(json['phone'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SourceIdModelToJson(SourceIdModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      if (instance.phone case final value?) 'phone': value,
    };

PhoneModel _$PhoneModelFromJson(Map<String, dynamic> json) => PhoneModel(
      countryCode: json['country_code'] as String,
      number: json['number'] as String,
    );

Map<String, dynamic> _$PhoneModelToJson(PhoneModel instance) =>
    <String, dynamic>{
      'country_code': instance.countryCode,
      'number': instance.number,
    };
