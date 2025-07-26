import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masarat/features/instructor/data/models/lesson/lesson_model.dart';
import 'package:masarat/features/instructor/data/repos/instructor_repo.dart';
import 'package:masarat/features/instructor/logic/upload_lesson_video/upload_lesson_video_state.dart';

class UploadLessonVideoCubit extends Cubit<UploadLessonVideoState> {
  final InstructorRepo _instructorRepo;

  UploadLessonVideoCubit(this._instructorRepo)
      : super(const UploadLessonVideoState.initial());

  Future<void> uploadLessonVideo(
    String lessonId,
    File videoFile,
  ) async {
    emit(const UploadLessonVideoState.loading());

    final result = await _instructorRepo.uploadLessonVideo(lessonId, videoFile);
    result.when(
      success: (data) {
        log('Upload Lesson Video success: $data');
        // Convert the data['lesson'] to a LessonModel
        if (data is Map<String, dynamic> && data.containsKey('lesson')) {
          try {
            final lessonData = data['lesson'] as Map<String, dynamic>;
            final lesson = LessonModel.fromJson(lessonData);
            emit(UploadLessonVideoState.success(lesson));
          } catch (e) {
            log('Error converting lesson data: $e');
            emit(const UploadLessonVideoState.error(
                'خطأ في معالجة بيانات الدرس'));
          }
        } else {
          emit(const UploadLessonVideoState.error('بيانات الدرس غير متوفرة'));
        }
      },
      failure: (error) {
        log('Upload Lesson Video error: ${error.message}');
        emit(UploadLessonVideoState.error(error.message ?? 'Unknown error'));
      },
    );
  }
}
