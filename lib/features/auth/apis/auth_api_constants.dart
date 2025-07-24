import 'package:masarat/core/config.dart';

class AuthenticationApiConstants {
  static String get apiBaseUrl => Config.get('apiUrl') as String;

  static const String login = 'api/v1/auth/login';
  static const String loginGoogle = 'api/v1/auth/login-google';
  static const String loginApple = 'api/v1/auth/login-apple';
  static const String createAccount = 'api/v1/auth/register';
  static const String createInstructorAccount =
      'api/v1/auth/register-instructor';
  static const String uploadAcademicDegree =
      'api/v1/auth/upload-academic-degree';
  static const String myProfile = 'api/v1/auth/my-profile';
  static const String delete = 'api/v1/users/delete';
  static const String forget = 'api/v1/auth/forgot-password';
}
