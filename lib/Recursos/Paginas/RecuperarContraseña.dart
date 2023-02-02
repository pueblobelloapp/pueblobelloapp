import 'package:flutter/material.dart';

class RecuperarContrasena extends StatefulWidget {
  RecuperarContrasena({Key? key}) : super(key: key);

  @override
  State<RecuperarContrasena> createState() => _RecuperarContrasenaState();
}

class _RecuperarContrasenaState extends State<RecuperarContrasena> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(),
      ),
    );
  }

  Widget ImagenLogo() {
    return Image.asset(
      'assets/img/Logo.png',
      width: 250,
      height: 250,
    );
  }
}
