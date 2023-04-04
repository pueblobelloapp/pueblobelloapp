import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Constants {
  static ButtonStyle buttonPrimary = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 15),
      backgroundColor: Colors.green,
      padding: EdgeInsets.symmetric(horizontal: 23.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)));

  static Color colorPrimary = Colors.white38;

  static const _kFontFam = 'MyFlutterApp';
  static const String? _kFontPkg = null;

  static const IconData google_plus_g =
      IconData(0xf0d5, fontFamily: _kFontFam, fontPackage: _kFontPkg);

  static InputDecoration decarationTextBox = InputDecoration(
      focusedBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      border: InputBorder.none,
      contentPadding: const EdgeInsets.all(16.0),
      fillColor: Colors.grey,
      hintText: 'Titulo informativo',
      hintStyle: TextStyle(color: Colors.white),
      prefixIcon: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FaIcon(
          FontAwesomeIcons.houseUser,
          color: Colors.green,
        ),
      ));

  static ButtonStyle flatButtonStyle = TextButton.styleFrom(
    foregroundColor: Colors.black87, minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
  );
}
