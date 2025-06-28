import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:masarat/features/instructor/data/models/category/category_model.dart';
import 'package:masarat/features/instructor/data/models/course/update_course_response.dart';

part 'update_course_state.freezed.dart';

@freezed
class UpdateCourseState with _$UpdateCourseState {
  const factory UpdateCourseState.initial() = _Initial;

  const factory UpdateCourseState.loadingCategories() = _LoadingCategories;

  const factory UpdateCourseState.categoriesLoaded(
      List<CategoryModel> categories) = _CategoriesLoaded;

  const factory UpdateCourseState.categoriesError(String error) =
      _CategoriesError;

  const factory UpdateCourseState.updating() = _Updating;

  const factory UpdateCourseState.updateSuccess(UpdateCourseResponse course) =
      _UpdateSuccess;

  const factory UpdateCourseState.updateError(String error) = _UpdateError;
}
