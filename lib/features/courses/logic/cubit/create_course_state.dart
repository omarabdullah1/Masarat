import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:masarat/features/courses/data/models/category_model.dart';

part 'create_course_state.freezed.dart';

@freezed
class CreateCourseState<T> with _$CreateCourseState<T> {
  const factory CreateCourseState.initial() = _Initial;

  const factory CreateCourseState.loading() = Loading;
  const factory CreateCourseState.success(T data) = CreateCourseSuccess<T>;
  const factory CreateCourseState.error({required String error}) = Error;

  const factory CreateCourseState.loadingCategories() = LoadingCategories;
  const factory CreateCourseState.categoriesLoaded(
      List<CategoryModel> categories) = CategoriesLoaded;
  const factory CreateCourseState.categoriesError({required String error}) =
      CategoriesError;
}
