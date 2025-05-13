import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension Navigation on BuildContext {
  /// Pushes a new screen on top of the current screen
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  /// Pushes a new screen and removes the previous screen
  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  /// Pushes a new screen and removes all the previous screens
  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {Object? arguments, required RoutePredicate predicate}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  /// Pushes a new screen on top of the current screen with BlocProvider
  Future<dynamic> pushNamedWithCubit<T extends Cubit<Object>>(
      String routeName, T cubit,
      {Object? arguments}) {
    return Navigator.of(this).pushNamed(
      routeName,
      arguments: {
        'cubit': cubit,
        'extraArgs': arguments,
      },
    );
  }

  /// Pops the current screen
  void pop() => Navigator.of(this).pop();

  /// Returns the [width] of the current screen
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Returns the [height] of the current screen
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Returns a [percentage] of the [width] of the current screen
  double pOW(double p) => MediaQuery.of(this).size.width * (p / 100);

  /// Returns a [percentage] of the [height] of the current screen
  double pOH(double p) => MediaQuery.of(this).size.height * (p / 100);
}

extension StringExtension on String? {
  /// Returns true if the string is null or empty
  bool isNullOrEmpty() => this == null || this == "";
}

extension ListExtension<T> on List<T>? {
  /// Returns true if the list is null or empty
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}
