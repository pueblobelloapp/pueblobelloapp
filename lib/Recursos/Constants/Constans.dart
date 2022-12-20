import 'package:flutter/material.dart';

class Constants {
  static ButtonStyle buttonPrimary =
    ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 15),
        backgroundColor: Colors.green
    );

  static Color colorPrimary = Colors.white38;

  static const _kFontFam = 'MyFlutterApp';
  static const String? _kFontPkg = null;

  static const IconData google_plus_g = IconData(0xf0d5, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}