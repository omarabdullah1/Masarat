import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:masarat/core/networking/api_error_model.dart';
import 'package:masarat/features/student/courses/data/models/lesson_details_model.dart';

part 'lesson_details_state.freezed.dart';

@freezed
class LessonDetailsState with _$LessonDetailsState {
  const factory LessonDetailsState.initial() = _Initial;
  const factory LessonDetailsState.loading() = _Loading;
  const factory LessonDetailsState.success(
      {required LessonDetailsModel lessonDetails}) = _Success;
  const factory LessonDetailsState.error({required ApiErrorModel error}) =
      _Error;
}
