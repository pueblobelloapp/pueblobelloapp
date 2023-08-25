import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppBasicColors {
  static const white = Color.fromRGBO(255, 255, 255, 1);
  static final green = Colors.green.shade600;
  static const rgb = Color.fromRGBO(0, 184, 148, 1);
  static const rgbTransparent = Color.fromRGBO(0, 184, 148, 0);
  static final lightGreen = Colors.green.shade400;
  static const lightGrey = Color(0xFFBBBBBB);
  static const black = Color.fromRGBO(0, 0, 0, 1);
  static const lightBlack = Colors.black38;
  static const lightWhite = Color(0x3DFFFFFF);
  static const yellow = Color.fromRGBO(249, 202, 36, 1);
  static const greyRgba = Color.fromRGBO(179, 190, 195, 1);
  static const greyMun = Color.fromRGBO(223, 230, 233, 1);
  static const blue = Color.fromRGBO(28, 162, 240, 1);
  static const transparent = Color.fromRGBO(0, 0, 0, 0);

  static const colorTextFormField = Color.fromRGBO(223, 230, 233, 1);
  static const colorButtonCancelar = Color.fromRGBO(45, 52, 54, 1);
  static const colorElevatedButtonBlue = Color.fromRGBO(33, 150, 243, 1);
  static const greenWhat = Color.fromRGBO(37, 212, 103, 1);
  static const redInst = Color.fromRGBO(238, 0, 18, 1);
  static const blueMess = Color.fromRGBO(0, 132, 255, 1);
  static const purpFace = Color.fromRGBO(65, 91, 154, 1);
  static const blueTwit = Color.fromRGBO(28, 162, 240, 1);

  static InputDecoration inputDecorationText = InputDecoration(
      prefixIcon: Padding(
        padding: const EdgeInsets.only(
            left: 6.0, top: 0.0, right: 12.0, bottom: 0.0),
      ),
      prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      fillColor: AppBasicColors.colorTextFormField,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(5.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(5.0),
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
      isCollapsed: true,
      contentPadding: const EdgeInsets.all(16.0),
      errorStyle: const TextStyle(color: AppBasicColors.white));
}
