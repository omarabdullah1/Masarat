import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkout_response.g.dart';

/// Response model for the checkout initiation process
@JsonSerializable()
class CheckoutResponse {
  /// Whether the checkout initiation was successful
  final bool success;

  /// The URL to redirect the user to for payment
  final String redirectUrl;

  /// The order ID
  final String orderId;

  /// Constructor
  CheckoutResponse({
    required this.success,
    required this.redirectUrl,
    required this.orderId,
  });

  /// Factory for JSON serialization
  factory CheckoutResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckoutResponseFromJson(json);

  /// Method for JSON serialization
  Map<String, dynamic> toJson() => _$CheckoutResponseToJson(this);
}
