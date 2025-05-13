import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masarat/core/helpers/constants.dart';
import 'package:masarat/core/helpers/shared_pref_helper.dart';
import 'package:masarat/core/networking/dio_factory.dart';
import 'package:masarat/core/theme/styles.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/features/auth/login/data/models/login_request_body.dart';
import 'package:masarat/features/auth/login/data/models/login_response.dart';
import 'package:masarat/features/auth/login/data/repos/login_repo.dart';
import 'package:masarat/features/auth/login/logic/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginRepo) : super(const LoginState.initial());
  final LoginRepo _loginRepo;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> emitLoginStates(BuildContext context) async {
    emit(const LoginState.loading());
    final response = await _loginRepo.login(
      LoginRequestBody(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    await response.when(
      success: (loginResponse) async {
        // Check if the response contains a valid token
        if (loginResponse.token.isEmpty) {
          // If no token, treat as an error even if API returned 200
          emit(
            const LoginState.error(
              error: 'Invalid login response: Missing token',
            ),
          );
          return;
        }

        // User data is directly in the response, not in a user object
        await SharedPrefHelper.setSecuredString(
          SharedPrefKeys.userAreaId,
          '', // This field is not in the API response, setting to empty
        );

        await SharedPrefHelper.setSecuredString(
          SharedPrefKeys.userName,
          '${loginResponse.firstName} ${loginResponse.lastName}',
        );

        await saveUserToken(loginResponse.token);
        if (context.mounted) {
          await userDataToString(loginResponse, context);
        }
        emit(LoginState.success(loginResponse));
      },
      failure: (error) {
        log('Login error: ${error.message}');
        emit(
          LoginState.error(
            error: error.message ?? '',
          ),
        );
      },
    );
  }

  Future<void> userDataToString(
    LoginResponse response,
    BuildContext context,
  ) async {
    try {
      await SharedPrefHelper.setSecuredString(
        SharedPrefKeys.userID,
        response.id,
      );
      final serializedData = jsonEncode(response.toJson());
      await saveUserData(serializedData);
    } catch (e) {
      log('Error serializing login response: $e');
      if (context.mounted) {
        throw Exception('Failed to serialize login response');
      }
    }
  }

  Future<void> saveUserToken(String token) async {
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, token);
    DioFactory.setTokenIntoHeaderAfterLogin(token);
  }

  Future<void> saveUserData(String response) async {
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userData, response);
  }

  bool isSigningIn = false;

  void snackbarShow(
    BuildContext context,
    String message, {
    Color? color,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyles.font12WhiteBold,
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: color ?? AppColors.gray,
      ),
    );
  }
}
