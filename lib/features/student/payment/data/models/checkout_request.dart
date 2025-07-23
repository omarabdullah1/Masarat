import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkout_request.g.dart';

/// Request model for initiating a checkout process
@JsonSerializable()
class CheckoutRequest {
  /// The source ID for the payment method
  final SourceId sourceId;

  /// The currency for the payment
  final String currency;

  /// Constructor
  CheckoutRequest({
    required this.sourceId,
    this.currency = 'SAR',
  });

  /// Factory for JSON serialization
  factory CheckoutRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckoutRequestFromJson(json);

  /// Method for JSON serialization
  Map<String, dynamic> toJson() => _$CheckoutRequestToJson(this);
}

/// Source ID model that contains payment method information
@JsonSerializable()
class SourceId {
  /// The payment method ID
  /// Valid values: src_sa.mada, src_apple_pay, src_google_pay, src_card, src_sa.stcpay
  final String id;

  /// Phone information for STC Pay
  final Phone? phone;

  /// Constructor
  SourceId({
    required this.id,
    this.phone,
  });

  /// Factory for JSON serialization
  factory SourceId.fromJson(Map<String, dynamic> json) =>
      _$SourceIdFromJson(json);

  /// Method for JSON serialization
  Map<String, dynamic> toJson() => _$SourceIdToJson(this);
}

/// Phone model for STC Pay
@JsonSerializable()
class Phone {
  /// The country code
  @JsonKey(name: 'country_code')
  final String countryCode;

  /// The phone number
  final String number;

  /// Constructor
  Phone({
    required this.countryCode,
    required this.number,
  });

  /// Factory for JSON serialization
  factory Phone.fromJson(Map<String, dynamic> json) => _$PhoneFromJson(json);

  /// Method for JSON serialization
  Map<String, dynamic> toJson() => _$PhoneToJson(this);
}
