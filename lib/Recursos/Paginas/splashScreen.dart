import 'package:app_turismo/Recursos/SystemNavegation/Routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:async';

import '../theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Future.delayed(const Duration(seconds: 1), () {
            _onShowLogin();
          });
        }
      });
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _animationController.dispose();
  }

  void _onShowLogin() {
    if (mounted) {
      Get.offAllNamed(Routes.Login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppBasicColors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[ImagenLogo(), TextAnimation(), ImagenLogoUnicesar()],
          ),
        ));
  }

  Widget ImagenLogo() {
    return Container(
      //padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: Image.asset(
        'assets/img/Logo.png',
        width: 250,
        height: 250,
      ),
    );
  }

  Widget ImagenLogoUnicesar() {
    return Container(
      child: Image.asset(
        'assets/img/UnicesarSinFondo.png',
        width: 250,
        height: 250,
      ),
    );
  }

  Widget TextAnimation() {
    return Container(
      child: Column(children: [
        Transform.scale(
          // ignore: unnecessary_null_comparison
          scale: _animation == null ? 0.3 : _animation.value,
          child: const Text(
            'IKU',
            style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: AppBasicColors.black //color negro cambiado a blanco
                ),
          ),
        ),
        Transform.scale(
          // ignore: unnecessary_null_comparison
          scale: _animation == null ? 1.0 : _animation.value,
          child: const Text('Admin',
              style: TextStyle(
                  fontSize: 20, //fontWeight:FontWeight.bold
                  color: AppBasicColors.black //color negro cambiado a blanco
                  )),
        ),
      ]),
    );
  }
}
