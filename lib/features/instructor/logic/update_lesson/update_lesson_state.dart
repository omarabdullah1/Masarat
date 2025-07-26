import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:masarat/features/instructor/data/models/lesson/lesson_model.dart';

part 'update_lesson_state.freezed.dart';

@freezed
class UpdateLessonState with _$UpdateLessonState {
  const factory UpdateLessonState.initial() = _Initial;
  const factory UpdateLessonState.loading() = _Loading;
  const factory UpdateLessonState.success(LessonModel lesson) = _Success;
  const factory UpdateLessonState.error(String error) = _Error;
}
