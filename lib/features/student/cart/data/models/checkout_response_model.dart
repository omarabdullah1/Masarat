import 'package:json_annotation/json_annotation.dart';

part 'checkout_response_model.g.dart';

@JsonSerializable()
class CheckoutResponseModel {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'redirectUrl')
  final String redirectUrl;

  @JsonKey(name: 'orderId')
  final String orderId;

  const CheckoutResponseModel({
    required this.success,
    required this.redirectUrl,
    required this.orderId,
  });

  factory CheckoutResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CheckoutResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutResponseModelToJson(this);
}

@JsonSerializable()
class CheckoutRootResponse {
  // The actual response doesn't have a data wrapper
  final bool success;
  final String redirectUrl;
  final String orderId;

  const CheckoutRootResponse({
    required this.success,
    required this.redirectUrl,
    required this.orderId,
  });

  factory CheckoutRootResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckoutRootResponseFromJson(json);

  // Helper to convert to CheckoutResponseModel
  CheckoutResponseModel toResponseModel() => CheckoutResponseModel(
        success: success,
        redirectUrl: redirectUrl,
        orderId: orderId,
      );
}
