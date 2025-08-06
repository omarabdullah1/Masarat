import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:masarat/features/auth/forget_password/data/models/reset_password_otp_request_body.dart';
import 'package:masarat/features/auth/forget_password/data/models/send_otp_request_body.dart';
import 'package:masarat/features/auth/forget_password/data/repos/forget_password_repo.dart';

part 'forget_password_cubit.freezed.dart';
part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this._forgetPasswordRepo)
      : super(const ForgetPasswordState.initial());

  final ForgetPasswordRepo _forgetPasswordRepo;

  final TextEditingController emailController = TextEditingController();

  String get email => emailController.text;

  Future<void> sendOtp(SendOtpRequestBody sendOtpRequestBody) async {
    emailController.text = sendOtpRequestBody.email;
    if (!isClosed) {
      emit(const ForgetPasswordState.loading());
    }
    final response = await _forgetPasswordRepo.sendOtp(sendOtpRequestBody);
    if (!isClosed) {
      response.whenOrNull(
        success: (message) => emit(ForgetPasswordState.success(message)),
        failure: (error) =>
            emit(ForgetPasswordState.error(error.message ?? '')),
      );
    }
  }

  Future<void> resetPasswordWithOtp(
      ResetPasswordOtpRequestBody resetPasswordOtpRequestBody) async {
    resetPasswordOtpRequestBody =
        resetPasswordOtpRequestBody.copyWith(email: emailController.text);
    if (!isClosed) {
      emit(const ForgetPasswordState.loading());
    }
    final response = await _forgetPasswordRepo
        .resetPasswordWithOtp(resetPasswordOtpRequestBody);
    if (!isClosed) {
      response.whenOrNull(
        success: (message) => emit(ForgetPasswordState.success(message)),
        failure: (error) =>
            emit(ForgetPasswordState.error(error.message ?? '')),
      );
    }
  }
}
