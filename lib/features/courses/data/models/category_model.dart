import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String iconUrl;
  final String createdAt;
  final String updatedAt;
  @JsonKey(name: '__v')
  final int v;

  CategoryModel({
    required this.id,
    required this.name,
    required this.iconUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
