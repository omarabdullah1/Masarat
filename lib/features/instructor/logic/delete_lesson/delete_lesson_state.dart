import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_lesson_state.freezed.dart';

@freezed
class DeleteLessonState with _$DeleteLessonState {
  const factory DeleteLessonState.initial() = _Initial;
  const factory DeleteLessonState.loading() = _Loading;
  const factory DeleteLessonState.success() = _Success;
  const factory DeleteLessonState.error(String error) = _Error;
}
