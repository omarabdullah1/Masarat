import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masarat/core/cubit/general_state.dart';
import 'package:masarat/core/helpers/shared_pref_helper.dart';
import 'package:masarat/core/networking/dio_factory.dart';

class GeneralCubit extends Cubit<GeneralState> {
  GeneralCubit() : super(const GeneralState.initial());
  String lang = 'ar';
  Locale local = const Locale('ar');

  /// Loads the saved language from SharedPreferences on startup.
  Future<void> loadLanguage() async {
    // You can choose to use a normal String method or the secured method.
    var lang = await SharedPrefHelper.getString('language_code');
    if (lang.isEmpty) {
      lang = 'ar'; // Default to English if none is stored
    }
    this.lang = lang;
    local = Locale(lang);
    DioFactory.setLanguageParameter(lang);
    emit(GeneralState.changeLanguage(lang));
  }

  /// Changes the language, saves it to SharedPreferences, and updates the state.
  Future<void> changeLanguage(String languageCode) async {
    // Save the selected language. You can use setData or setSecuredString.
    await SharedPrefHelper.setData('language_code', languageCode);
    lang = languageCode;
    local = Locale(lang);

    DioFactory.setLanguageParameter(lang);
    // Emit the new state so the UI can rebuild with the new locale.
    emit(GeneralState.changeLanguage(languageCode));
  }
}
