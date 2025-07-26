import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masarat/features/instructor/profile/data/models/profile_update_error.dart';
import 'package:masarat/features/instructor/profile/data/repositories/instructor_profile_repository.dart';

import '../../data/models/instructor_profile_response.dart';
import 'instructor_profile_state.dart';

class InstructorProfileCubit extends Cubit<InstructorProfileState> {
  Future<void> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String contactNumber,
    required String nationality,
    required String countryOfResidence,
    required String governorate,
    required String academicDegree,
    required String specialty,
    required String jobTitle,
    required String workEntity,
    File? profilePicture,
  }) async {
    try {
      emit(const InstructorProfileState.loading());
      final updatedProfile = await _repository.updateProfile(
        firstName: firstName.trim(),
        lastName: lastName.trim(),
        email: email.trim(),
        contactNumber: contactNumber.trim(),
        nationality: nationality.trim(),
        countryOfResidence: countryOfResidence.trim(),
        governorate: governorate.trim(),
        academicDegree: academicDegree.trim(),
        specialty: specialty.trim(),
        jobTitle: jobTitle.trim(),
        workEntity: workEntity.trim(),
        profilePicture: profilePicture,
      );
      profile = updatedProfile;
      emit(InstructorProfileState.updateSuccess(updatedProfile));
      emit(InstructorProfileState.loaded(updatedProfile));
    } on ProfileUpdateError catch (e) {
      emit(InstructorProfileState.error(e.message));
    } catch (e) {
      emit(const InstructorProfileState.error('An unexpected error occurred'));
    }
  }

  final InstructorProfileRepository _repository;

  // Controllers are now managed in the UI layer

  // Form key for validation
  final formKey = GlobalKey<FormState>();

  // Profile data
  InstructorProfileResponse? profile;

  InstructorProfileCubit(this._repository)
      : super(const InstructorProfileState.initial());

  // No controller disposal needed

  Future<void> fetchProfile() async {
    if (isClosed) return;

    try {
      emit(const InstructorProfileState.loading());
      final profileData = await _repository.getProfile();
      profile = profileData;
      emit(InstructorProfileState.loaded(profileData));
    } on ProfileUpdateError catch (e) {
      emit(InstructorProfileState.error(e.message));
    } catch (e) {
      emit(const InstructorProfileState.error('An unexpected error occurred'));
    }
  }
}
