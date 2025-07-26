import 'package:json_annotation/json_annotation.dart';

part 'course_cart_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CourseCartModel {
  @JsonKey(name: '_id')
  final String id;
  final String title;
  final String? instructor; // Nullable instructor
  final String coverImageUrl;
  final double price;

  // Factory constructor for more robust parsing
  static CourseCartModel fromMap(Map<String, dynamic> map) {
    return CourseCartModel(
      id: map['_id'] as String,
      title: map['title'] as String,
      instructor: map['instructor'] as String?, // Might be null
      coverImageUrl: map['coverImageUrl'] as String,
      price: (map['price'] as num).toDouble(),
    );
  }

  CourseCartModel({
    required this.id,
    required this.title,
    this.instructor, // Optional
    required this.coverImageUrl,
    required this.price,
  });

  factory CourseCartModel.fromJson(Map<String, dynamic> json) =>
      _$CourseCartModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseCartModelToJson(this);
}
