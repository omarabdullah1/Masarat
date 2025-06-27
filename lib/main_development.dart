import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masarat/app/app.dart';
import 'package:masarat/bootstrap.dart';
import 'package:masarat/core/config.dart';
import 'package:masarat/core/helpers/constants.dart';

void main() {
  // Set the flavor for development environment
  Config.setFlavor('development');

  bootstrap(
    () => EasyLocalization(
      path: Constants.i18nPath,
      supportedLocales: const [
        Locale(Constants.enLang),
        Locale(Constants.arLang),
      ],
      child: const MasaratApp(),
    ),
  );
}
