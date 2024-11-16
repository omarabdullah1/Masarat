import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/utils/constants.dart';
import 'package:masarat/counter/counter.dart';
import 'package:masarat/features/auth/login/presentation/pages/login_screen.dart';
import 'package:masarat/features/auth/presentation/pages/onboarding_screen.dart';
import 'package:masarat/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
    splitScreenMode: true,
    // Use builder only if you need to use library outside ScreenUtilInit context
    builder: (_ , child) {
      return MaterialApp(
       debugShowCheckedModeBanner: false,

        theme: ThemeData(
          fontFamily: Constants.fontName,

          useMaterial3: true,
        ),
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ar', 'AE'),
        ],
        locale: const Locale('ar', 'AE'),


        home:   LoginScreen(),
      );},
    );
  }
}
