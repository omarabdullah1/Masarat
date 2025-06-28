import 'package:flutter/material.dart';

bool isLoggedInUser = false;

class SharedPrefKeys {
  // private constructor to prevent creating an instance
  SharedPrefKeys._();

  static const String userToken = 'userToken';
  static const String userName = 'userName';
  static const String userData = 'userData';
  static const String userID = 'userID';
  static const String userRole = 'userRole';
  static const String userAreaId =
      'userAreaId'; // Make sure this is the exact key being used
  static const String language = 'language_code';
}

class Constants {
  static const String appName = 'Masarat';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';
  static const String appPackage = 'com.masarat.ksa';
  static const String appStoreLink =
      'https://play.google.com/store/apps/details?id=$appPackage';
  static const String appStoreId = 'com.masarat.ksa';
  static const String appStoreName = 'masarat';
  static const String appStoreDescription =
      'Wardaya is a mobile application that helps you to learn and improve your skills in different fields.';

  static const String i18nPath = 'assets/i18n';

  static const String appStorePrivacyPolicy =
      'https://masarat.com/privacy-policy';
  static const String appStoreTermsOfService =
      'https://masarat.com/terms-of-service';
  static const String appStoreContactEmail = ' [email protected]';
  static const String appStoreContactPhone = '+20123456789';
  static const String appStoreContactWebsite = 'https://masarat.com';
  static const String arLang = 'ar';
  static const String enLang = 'en';
  static const String fontName = 'Montserrat';
  static void showDialogError({
    required BuildContext context,
    required String msg,
  }) {
    showDialog<void>(
      context: context,
      builder: (
        context,
      ) =>
          Center(
        child: Dialog(
          child: Column(
            children: [
              Text(msg),
            ],
          ),
        ),
      ),
    );
  }
}
