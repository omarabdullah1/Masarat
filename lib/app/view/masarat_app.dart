import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:masarat/config/app_router.dart';
import 'package:masarat/core/helpers/constants.dart';
import 'package:masarat/core/utils/app_colors.dart';

class MasaratApp extends StatelessWidget {
  final bool isDevelopmentMode;
  final GoRouter? customRouter;

  const MasaratApp({
    super.key,
    this.isDevelopmentMode = false,
    this.customRouter,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use the library
      // outside the ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: isDevelopmentMode,
          title: isDevelopmentMode ? 'مسارات (تطوير)' : 'مسارات',
          theme: ThemeData(
            fontFamily: Constants.fontName,
            appBarTheme: const AppBarTheme(color: AppColors.background),
            useMaterial3: false,
            colorScheme: isDevelopmentMode
                ? ColorScheme.fromSeed(seedColor: Colors.green)
                : null,
          ),
          localizationsDelegates: isDevelopmentMode
              ? context.localizationDelegates
              : const [
                  GlobalCupertinoLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
          supportedLocales: isDevelopmentMode
              ? context.supportedLocales
              : const [Locale('ar', 'AE')],
          locale: isDevelopmentMode ? context.locale : const Locale('ar', 'AE'),
          routerConfig: customRouter ?? router,
        );
      },
    );
  }
}
