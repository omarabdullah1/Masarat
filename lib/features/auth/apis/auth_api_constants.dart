import 'package:masarat/core/config.dart';

class AuthenticationApiConstants {
  static String get apiBaseUrl => Config.get('apiUrl') as String;

  static const String login = 'api/auth/login';
  static const String loginGoogle = 'api/auth/login-google';
  static const String loginApple = 'api/auth/login-apple';
  static const String createAccount = 'api/auth/register';
  static const String myProfile = 'api/auth/my-profile';
  static const String delete = 'api/users/delete';
  static const String forget = 'api/auth/forgot-password';
}
