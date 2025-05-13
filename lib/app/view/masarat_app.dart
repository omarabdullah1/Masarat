import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masarat/config/app_router.dart';
import 'package:masarat/core/helpers/constants.dart';
import 'package:masarat/core/utils/app_colors.dart';

class MasaratApp extends StatelessWidget {
  const MasaratApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use the library
      // outside the ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: Constants.fontName,
            appBarTheme: const AppBarTheme(color: AppColors.background),
            useMaterial3: false,
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
          routerConfig: router,
        );
      },
    );
  }
}
