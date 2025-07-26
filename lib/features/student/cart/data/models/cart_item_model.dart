import 'package:json_annotation/json_annotation.dart';

import 'course_cart_model.dart';

part 'cart_item_model.g.dart';

@JsonSerializable()
class CartItemModel {
  final CourseCartModel course;
  final double price;

  CartItemModel({
    required this.course,
    required this.price,
  });

  // Custom fromJson to handle potential missing fields
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$CartItemModelFromJson(json);
    } catch (e) {
      // If standard parsing fails, try a more forgiving approach
      final courseData = json['course'] as Map<String, dynamic>;
      return CartItemModel(
        course: CourseCartModel.fromMap(courseData),
        price: (json['price'] as num).toDouble(),
      );
    }
  }

  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);
}
