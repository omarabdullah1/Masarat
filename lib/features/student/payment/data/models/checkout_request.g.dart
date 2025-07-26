// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckoutRequest _$CheckoutRequestFromJson(Map<String, dynamic> json) =>
    CheckoutRequest(
      sourceId: SourceId.fromJson(json['sourceId'] as Map<String, dynamic>),
      currency: json['currency'] as String? ?? 'SAR',
    );

Map<String, dynamic> _$CheckoutRequestToJson(CheckoutRequest instance) =>
    <String, dynamic>{
      'sourceId': instance.sourceId,
      'currency': instance.currency,
    };

SourceId _$SourceIdFromJson(Map<String, dynamic> json) => SourceId(
      id: json['id'] as String,
      phone: json['phone'] == null
          ? null
          : Phone.fromJson(json['phone'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SourceIdToJson(SourceId instance) => <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
    };

Phone _$PhoneFromJson(Map<String, dynamic> json) => Phone(
      countryCode: json['country_code'] as String,
      number: json['number'] as String,
    );

Map<String, dynamic> _$PhoneToJson(Phone instance) => <String, dynamic>{
      'country_code': instance.countryCode,
      'number': instance.number,
    };
