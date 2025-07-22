import 'package:json_annotation/json_annotation.dart';

import 'cart_item_model.dart';

part 'cart_response_model.g.dart';

@JsonSerializable()
class CartResponseModel {
  @JsonKey(name: '_id')
  final String id;
  final String user;
  final List<CartItemModel> items;
  final double totalAmount;
  final String createdAt;
  final String updatedAt;
  @JsonKey(name: '__v')
  final int version;

  CartResponseModel({
    required this.id,
    required this.user,
    required this.items,
    required this.totalAmount,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory CartResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CartResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartResponseModelToJson(this);
}
