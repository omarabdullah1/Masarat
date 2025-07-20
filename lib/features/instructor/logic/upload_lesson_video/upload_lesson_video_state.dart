import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:masarat/features/instructor/data/models/lesson/lesson_model.dart';

part 'upload_lesson_video_state.freezed.dart';

@freezed
class UploadLessonVideoState with _$UploadLessonVideoState {
  const factory UploadLessonVideoState.initial() = _Initial;
  const factory UploadLessonVideoState.loading() = _Loading;
  const factory UploadLessonVideoState.success(LessonModel lesson) = _Success;
  const factory UploadLessonVideoState.error(String error) = _Error;
}
