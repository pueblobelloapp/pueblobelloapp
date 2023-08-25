import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Constants {
  static ButtonStyle buttonPrimary = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 15),
      backgroundColor: Colors.green,
      padding: EdgeInsets.symmetric(horizontal: 23.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)));

  static ButtonStyle buttonCancel = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 15, color: Colors.white),
      backgroundColor: Colors.red,
      padding: EdgeInsets.symmetric(horizontal: 23.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)));

  static Color colorPrimary = Colors.white38;

  static const _kFontFam = 'MyFlutterApp';
  static const String? _kFontPkg = null;

  static const IconData google_plus_g =
      IconData(0xf0d5, fontFamily: _kFontFam, fontPackage: _kFontPkg);

  static ButtonStyle flatButtonStyle = TextButton.styleFrom(
    foregroundColor: Colors.black87,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
  );

  static String urlPhotoPerfil =
      "https://firebasestorage.googleapis.com/v0/b/pueblobello-turismo.appspot.com/o/posts%2Fdata%2Fuser%2F0%2Fcom.example.app_turismo%2Fcache%2Fusuario_login.png?alt=media&token=cb64454b-ca38-4829-be9a-eb0d8817bf77";
}
