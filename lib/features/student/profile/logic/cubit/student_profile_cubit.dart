import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:masarat/features/student/profile/data/models/student_profile_response.dart';
import 'package:masarat/features/student/profile/data/repositories/student_profile_repository.dart';

part 'student_profile_cubit.freezed.dart';

class StudentProfileCubit extends Cubit<StudentProfileState> {
  final StudentProfileRepository _repository;
  // Removed firstNameController, lastNameController, emailController (now in UI)
  final TextEditingController phoneController = TextEditingController();
  StudentProfileResponse? profile;

  StudentProfileCubit(this._repository)
      : super(const StudentProfileState.initial());

  Future<void> fetchProfile() async {
    try {
      emit(const StudentProfileState.loading());
      profile = await _repository.getProfile();

      // No controller updates here; UI manages its own controllers
      phoneController.text = profile?.phone ?? '';

      emit(StudentProfileState.loaded(profile!));
    } catch (e) {
      emit(StudentProfileState.error(e.toString()));
    }
  }

  Future<void> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
    File? profileImage,
  }) async {
    try {
      emit(const StudentProfileState.loading());
      await _repository.updateProfile(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phoneController.text.isNotEmpty ? phoneController.text : null,
        profileImage: profileImage,
      );
      emit(const StudentProfileState.updateSuccess());
    } catch (e) {
      emit(StudentProfileState.error(e.toString()));
    }
  }

  @override
  Future<void> close() {
    phoneController.dispose();
    return super.close();
  }
}

@freezed
abstract class StudentProfileState with _$StudentProfileState {
  const factory StudentProfileState.initial() = _Initial;
  const factory StudentProfileState.loading() = _Loading;
  const factory StudentProfileState.loaded(StudentProfileResponse profile) =
      _Loaded;
  const factory StudentProfileState.error(String message) = _Error;
  const factory StudentProfileState.updateSuccess() = _UpdateSuccess;
}
