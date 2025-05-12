import 'package:flutter/material.dart';

class Constants {
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
