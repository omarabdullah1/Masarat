import 'package:freezed_annotation/freezed_annotation.dart';
part 'register_state.freezed.dart';

@freezed
class RegisterState<T> with _$RegisterState {
  const factory RegisterState.initial() = _Initial;
  const factory RegisterState.loading() = Loading;
  const factory RegisterState.success(T data) = RegisterSuccess<T>;
  const factory RegisterState.error({required String error}) = Error;

  const factory RegisterState.setCountryCode(String countryCode) = CountryCode;
  const factory RegisterState.setBirthDate(String birthdate) = BirthDate;
  const factory RegisterState.togglePasswordVisibility(bool isPasswordVisable) =
      TogglePasswordVisibility;
}
