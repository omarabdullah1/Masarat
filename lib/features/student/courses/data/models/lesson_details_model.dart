import 'package:json_annotation/json_annotation.dart';

// Removed unused imports

part 'lesson_details_model.g.dart';

@JsonSerializable()
class LessonDetailsModel {
  LessonDetailsModel({
    required this.id,
    required this.title,
    this.content,
    this.contentType,
    this.order,
    this.durationEstimate,
    this.isPreviewable = false,
    this.videoId,
    this.videoLibraryId,
  });

  factory LessonDetailsModel.fromJson(Map<String, dynamic> json) {
    // Since the g.dart file might not be generated yet
    return LessonDetailsModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      content: json['content'] as String?,
      contentType: json['contentType'] as String?,
      order: json['order'] as int?,
      durationEstimate: _handleDurationEstimate(json['durationEstimate']),
      isPreviewable: json['isPreviewable'] as bool? ?? false,
      videoId: json['videoId'] as String?,
      videoLibraryId: json['videoLibraryId'] as String?,
    );
  }

  @JsonKey(name: '_id')
  final String id;
  final String title;
  final String? content;
  final String? contentType;
  final int? order;
  final String? durationEstimate;
  final bool? isPreviewable;

  // Helper method to handle duration estimate conversion
  static String? _handleDurationEstimate(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    if (value is int) return value.toString();
    return value.toString();
  }

  // Video properties
  final String? videoId;
  final String? videoLibraryId;

  Map<String, dynamic> toJson() {
    // Since the g.dart file might not be generated yet
    return {
      '_id': id,
      'title': title,
      'content': content,
      'contentType': contentType,
      'order': order,
      'durationEstimate': durationEstimate,
      'isPreviewable': isPreviewable,
      'videoId': videoId,
      'videoLibraryId': videoLibraryId,
    };
  }

  // Helper method to construct M3U URL
  String? getM3uUrl({String? token}) {
    if (videoId == null) {
      return null;
    }

    // Using the correct CDN URL format based on the provided URL structure
    // Format: https://vz-d81d8c7d-6eb.b-cdn.net/{videoId}/playlist.m3u8

    // Base CDN URL
    const String cdnBaseUrl = 'https://vz-d81d8c7d-6eb.b-cdn.net';

    // Construct the URL with the correct format
    String cdnUrl = '$cdnBaseUrl/$videoId/playlist.m3u8';

    // Add token if provided (needed for authorization)
    if (token != null && token.isNotEmpty) {
      cdnUrl = '$cdnUrl?token=$token';
    }

    print('Generated M3U URL (CDN format): $cdnUrl');

    // This is the correct format based on the provided example:
    // https://vz-d81d8c7d-6eb.b-cdn.net/d234d488-f7d1-4077-b236-3e7cf69c1359/playlist.m3u8
    return cdnUrl;
  }

  // Check if the video needs authorization token
  // This method helps determine if the current video requires a token
  bool needsAuthToken() {
    // If the video is not previewable, it likely needs authorization
    return isPreviewable == false;
  }
}
