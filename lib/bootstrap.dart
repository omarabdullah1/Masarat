import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:masarat/core/config.dart';
import 'package:masarat/core/di/dependency_injection.dart';
import 'package:masarat/core/networking/dio_factory.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await setupGetIt();

  // Apply SSL certificate bypass directly to handle expired certificates
  DioFactory.applySslBypass();

  // Log environment information
  var environment = Config.flavor;
  log('App running in $environment environment');

// Cross-flavor configuration
  // final apiUrl = Config.get('apiUrl');
  final enableLogging = Config.get('enableLogging') as bool;

  log('Logging is enabled for$enableLogging mode');

  runApp(await builder());
}
