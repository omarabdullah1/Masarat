import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:masarat/features/student/courses/data/models/course_model.dart';

part 'training_courses_state.freezed.dart';

@freezed
class TrainingCoursesState with _$TrainingCoursesState {
  const factory TrainingCoursesState.initial() = _Initial;
  const factory TrainingCoursesState.loading() = _Loading;
  const factory TrainingCoursesState.success(List<CourseModel> courses) =
      _Success;
  const factory TrainingCoursesState.error(String message) = _Error;
}
