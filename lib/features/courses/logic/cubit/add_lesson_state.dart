import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:masarat/features/courses/data/models/add_lesson_response.dart';

part 'add_lesson_state.freezed.dart';

@freezed
class AddLessonState<T> with _$AddLessonState<T> {
  const factory AddLessonState.initial() = _Initial;
  const factory AddLessonState.loading() = Loading;
  const factory AddLessonState.success(AddLessonResponse data) =
      AddLessonSuccess;
  const factory AddLessonState.error({required String error}) = Error;
}
