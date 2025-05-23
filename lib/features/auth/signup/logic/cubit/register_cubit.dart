import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masarat/features/auth/signup/data/repos/create_account_repo.dart';

import '../../data/models/create_account_request_body.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final CreateAccountRepo _createAccountRepo;

  RegisterCubit(this._createAccountRepo) : super(const RegisterState.initial());
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController academicDegreeController =
      TextEditingController();

  final GlobalKey<TooltipState> fullNameTooltipKey = GlobalKey<TooltipState>();
  final GlobalKey<TooltipState> emailTooltipKey = GlobalKey<TooltipState>();
  final GlobalKey<TooltipState> passwordTooltipKey = GlobalKey<TooltipState>();
  final GlobalKey<TooltipState> phoneTooltipKey = GlobalKey<TooltipState>();

  bool isPasswordVisible = false;
  String? academicDegreeFilePath;

  void emitRegisterStates({
    required String fullName,
    required String password,
    String? phone,
    required String email,
    String? idNumber,
  }) async {
    final names = splitFullName(fullName);
    final firstName = names['firstName']!;
    final lastName = names['lastName']!;

    emit(const RegisterState.loading());

    // Only include phone number and country code if the phone is not empty
    final String? phoneNumber =
        phone != null && phone.trim().isNotEmpty ? phone : null;
    // final String? phoneCountryCode = phoneNumber != null ? countryCode : null;

    final response = await _createAccountRepo.createAccount(
      CreateAccountRequestBody(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber!,
        academicDegreePath: academicDegreeFilePath,
        idNumber: idNumber,
      ),
    );

    log('Registration API response: $response');

    response.when(success: (registerResponse) {
      // Check if there's an error message in the response despite a "success" HTTP status
      log('Registration success: $registerResponse');
      emit(RegisterState.success(registerResponse));
    }, failure: (error) {
      log('Registration failure: ${error.error} - ${error.message}');
      // Use error.error if available, otherwise fall back to error.message
      final errorMessage = error.message?.isNotEmpty == true
          ? error.message!
          : (error.message?.isNotEmpty == true
              ? error.message!
              : 'Registration failed');
      emit(RegisterState.error(error: errorMessage));
    });
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(RegisterState.togglePasswordVisibility(isPasswordVisible));
  }

  void setAcademicDegreeFile(String filePath, String fileName) {
    academicDegreeFilePath = filePath;
    academicDegreeController.text = fileName;

    // Get file type based on extension
    final fileType = getFileType(fileName);

    // Log file information
    log('File selected: $fileName | Type: $fileType | Path: $filePath');

    // Refresh UI
    emit(const RegisterState.initial());
  }

  // Helper method to determine file type from file name
  String getFileType(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();

    switch (extension) {
      case 'pdf':
        return 'PDF';
      case 'jpg':
      case 'jpeg':
      case 'png':
        return 'Image';
      case 'doc':
      case 'docx':
        return 'Word Document';
      default:
        return 'Unknown';
    }
  }

  Map<String, String> splitFullName(String fullName) {
    const String specialEmptyChar = '؜'; // Special empty character

    // Remove any leading/trailing spaces and multiple spaces between words
    final cleanedFullName = fullName.trim().replaceAll(RegExp(r'\s+'), ' ');

    // Split the name by single space
    final nameParts = cleanedFullName.split(' ');

    // Get firstName and handle lastName
    final firstName = nameParts[0];
    final lastName = nameParts.length > 1 && nameParts[1].isNotEmpty
        ? nameParts.sublist(1).join(' ')
        : specialEmptyChar;

    return {
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}
