import 'package:json_annotation/json_annotation.dart';

import 'cart_response_model.dart';

part 'cart_root_response.g.dart';

@JsonSerializable()
class CartRootResponse {
  final bool success;
  final CartResponseModel data;

  CartRootResponse({
    required this.success,
    required this.data,
  });

  factory CartRootResponse.fromJson(Map<String, dynamic> json) =>
      _$CartRootResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CartRootResponseToJson(this);
}
