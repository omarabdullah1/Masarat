import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:masarat/features/instructor/data/models/course/instructor_courses_response.dart';

part 'instructor_courses_state.freezed.dart';

@freezed
class InstructorCoursesState<T> with _$InstructorCoursesState<T> {
  const factory InstructorCoursesState.initial() = _Initial;
  const factory InstructorCoursesState.loading() = Loading;
  const factory InstructorCoursesState.success(InstructorCoursesResponse data) =
      PublishedCoursesSuccess;
  const factory InstructorCoursesState.error({required String error}) = Error;
  // Added states for pagination
  const factory InstructorCoursesState.loadingMore(
      InstructorCoursesResponse data) = LoadingMore;
  const factory InstructorCoursesState.loadMoreError(
      {required InstructorCoursesResponse data,
      required String error}) = LoadMoreError;
}
