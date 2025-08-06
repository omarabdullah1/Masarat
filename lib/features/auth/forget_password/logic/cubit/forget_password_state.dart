part of 'forget_password_cubit.dart';

@freezed
abstract class ForgetPasswordState with _$ForgetPasswordState {
  const factory ForgetPasswordState.initial() = _Initial;
  const factory ForgetPasswordState.loading() = Loading;
  const factory ForgetPasswordState.success(String message) = Success;
  const factory ForgetPasswordState.error(String error) = Error;
}
