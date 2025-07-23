import 'package:json_annotation/json_annotation.dart';

part 'checkout_request_model.g.dart';

@JsonSerializable()
class CheckoutRequestModel {
  @JsonKey(name: 'sourceId')
  final SourceIdModel sourceId;

  @JsonKey(name: 'currency')
  final String currency;

  const CheckoutRequestModel({
    required this.sourceId,
    required this.currency,
  });

  factory CheckoutRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CheckoutRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutRequestModelToJson(this);
}

@JsonSerializable()
class SourceIdModel {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'phone', includeIfNull: false)
  final PhoneModel? phone;

  const SourceIdModel({
    required this.id,
    this.phone,
  });

  factory SourceIdModel.fromJson(Map<String, dynamic> json) =>
      _$SourceIdModelFromJson(json);

  Map<String, dynamic> toJson() => _$SourceIdModelToJson(this);
}

@JsonSerializable()
class PhoneModel {
  @JsonKey(name: 'country_code')
  final String countryCode;

  @JsonKey(name: 'number')
  final String number;

  const PhoneModel({
    required this.countryCode,
    required this.number,
  });

  factory PhoneModel.fromJson(Map<String, dynamic> json) =>
      _$PhoneModelFromJson(json);

  Map<String, dynamic> toJson() => _$PhoneModelToJson(this);
}
