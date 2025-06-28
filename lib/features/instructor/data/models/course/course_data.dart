class CourseData {
  final String id;
  final String title;
  final String description;
  final String level;
  final String durationEstimate;
  final List<String> tags;
  final double price;
  final String categoryId;
  final String? verificationStatus;
  final bool? isPublished;

  CourseData({
    required this.id,
    required this.title,
    required this.description,
    required this.level,
    required this.durationEstimate,
    required this.tags,
    required this.price,
    required this.categoryId,
    this.verificationStatus,
    this.isPublished,
  });

  // Factory constructor to create from the API response
  factory CourseData.fromUpdateResponse(Map<String, dynamic> json) {
    return CourseData(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      level: json['level'] ?? '',
      durationEstimate: json['durationEstimate'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      price: (json['price'] ?? 0.0).toDouble(),
      categoryId: json['category'] ?? '',
      verificationStatus: json['verificationStatus'],
      isPublished: json['isPublished'],
    );
  }
}
