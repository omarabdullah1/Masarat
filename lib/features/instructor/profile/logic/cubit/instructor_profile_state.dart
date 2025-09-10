import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:masarat/features/instructor/profile/data/models/instructor_profile_response.dart';

part 'instructor_profile_state.freezed.dart';

@freezed
class InstructorProfileState with _$InstructorProfileState {
  const factory InstructorProfileState.initial() = _Initial;
  const factory InstructorProfileState.loading() = _Loading;
  const factory InstructorProfileState.loaded(
      InstructorProfileResponse profile) = _Loaded;
  const factory InstructorProfileState.updateSuccess(
      InstructorProfileResponse profile) = _UpdateSuccess;
  const factory InstructorProfileState.error(String message) = _Error;
  const factory InstructorProfileState.deleteSuccess() = _DeleteSuccess;
}
