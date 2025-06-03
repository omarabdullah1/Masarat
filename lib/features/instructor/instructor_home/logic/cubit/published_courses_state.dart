import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:masarat/features/instructor/instructor_home/data/models/published_courses_response.dart';

part 'published_courses_state.freezed.dart';

@freezed
class PublishedCoursesState<T> with _$PublishedCoursesState<T> {
  const factory PublishedCoursesState.initial() = _Initial;
  const factory PublishedCoursesState.loading() = Loading;
  const factory PublishedCoursesState.success(PublishedCoursesResponse data) =
      PublishedCoursesSuccess;
  const factory PublishedCoursesState.error({required String error}) = Error;
  // Added states for pagination
  const factory PublishedCoursesState.loadingMore(
      PublishedCoursesResponse data) = LoadingMore;
  const factory PublishedCoursesState.loadMoreError(
      {required PublishedCoursesResponse data,
      required String error}) = LoadMoreError;
}
