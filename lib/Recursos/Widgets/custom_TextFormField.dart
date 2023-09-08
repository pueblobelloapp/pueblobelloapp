import 'package:app_turismo/Recursos/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final Icon? icon;
  final String textGuide;
  final bool obscureText;
  final String? msgError;
  final TextInputType? textInputType;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final bool readOnly;
  final VoidCallback? onTap;
  final int? maxLinesText;
  final bool valueFocus;

  const CustomTextFormField(
      {super.key,
      this.controller,
      this.icon,
      required this.textGuide,
      required this.obscureText,
      this.textInputType,
      this.contentPadding = const EdgeInsets.all(16.0),
      this.fillColor = AppBasicColors.white,
      this.msgError,
      this.readOnly = false,
      this.onTap,
      this.maxLinesText = 1,
      this.valueFocus = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      obscureText: obscureText,
      readOnly: readOnly,
      onTap: onTap,
      maxLines: maxLinesText,
      autofocus: valueFocus,
      decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.only(
                top: 0.0, right: 10.0, bottom: 0.0, left: 10.0),
            child: icon,
          ),
          prefixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          fillColor: fillColor,
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
          hintText: textGuide,
          contentPadding: contentPadding,
          isCollapsed: true,
          hintStyle: const TextStyle(color: Colors.black26),
          errorStyle: const TextStyle(color: AppBasicColors.redInst)),
      validator: (value) {
        print(value);
        if (value!.isEmpty) {
          return msgError;
        }
      },
      cursorColor: AppBasicColors.black,
    );
  }
}
