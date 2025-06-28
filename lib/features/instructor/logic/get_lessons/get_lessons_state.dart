import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:masarat/features/instructor/data/models/lesson/lesson_model.dart';

part 'get_lessons_state.freezed.dart';

@freezed
class GetLessonsState with _$GetLessonsState {
  const factory GetLessonsState.initial() = _Initial;
  const factory GetLessonsState.loading() = GetLessonsLoading;
  const factory GetLessonsState.success(List<LessonModel> lessons) =
      GetLessonsSuccess;
  const factory GetLessonsState.error(String error) = GetLessonsError;
}
