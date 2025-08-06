import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';

class AddLessonRequestBody {
  final String title;
  final String contentType;
  final String courseId;
  final int order;
  final bool isPreviewable;
  final PlatformFile? videoFile;
  final List<PlatformFile>? resources;
  final String? content;

  AddLessonRequestBody({
    required this.title,
    required this.contentType,
    required this.courseId,
    required this.order,
    required this.isPreviewable,
    this.videoFile,
    this.resources,
    this.content,
  });

  Future<Map<String, dynamic>> toFormDataMap() async {
    MultipartFile? videoMultipart;
    if (videoFile != null) {
      videoMultipart = MultipartFile.fromBytes(
        videoFile!.bytes ?? await File(videoFile!.path!).readAsBytes(),
        filename: videoFile!.name,
        contentType: MediaType('video', videoFile!.extension ?? 'mp4'),
      );
    }
    final List<MultipartFile> resourceFiles = resources != null
        ? await Future.wait(resources!.map((f) async => MultipartFile.fromBytes(
              f.bytes ?? await File(f.path!).readAsBytes(),
              filename: f.name,
            )))
        : [];
    return {
      'title': title,
      'contentType': contentType,
      'courseId': courseId,
      'order': order,
      'isPreviewable': isPreviewable.toString(),
      if (videoMultipart != null) 'videoFile': videoMultipart,
      if (resourceFiles.isNotEmpty) 'resources': resourceFiles,
      if (content != null) 'content': content,
    };
  }
}
