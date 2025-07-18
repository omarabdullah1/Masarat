import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';
import 'package:masarat/app/app.dart';
import 'package:masarat/bootstrap.dart';
import 'package:masarat/core/config.dart';
import 'package:masarat/core/helpers/constants.dart';

void main() {
  // Set the flavor for production environment
  Config.setFlavor('production');

  bootstrap(
    () => EasyLocalization(
      path: Constants.i18nPath,
      supportedLocales: const [
        Locale(Constants.enLang),
        Locale(Constants.arLang),
      ],
      assetLoader: const YamlAssetLoader(), // Use YAML loader for .yaml files
      child: const MasaratApp(),
    ),
  );
}
