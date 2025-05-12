import 'dart:ui';
import 'package:flutter/material.dart';

class HexColor extends Color {
  HexColor(String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    var processedHexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (processedHexColor.length == 6) {
      processedHexColor = 'FF$processedHexColor';
    }
    return int.parse(processedHexColor, radix: 16);
  }
}
