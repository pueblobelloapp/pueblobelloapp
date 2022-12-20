import 'package:app_turismo/Recursos/Paginas/SplashScreen.dart';
import 'package:app_turismo/Recursos/Paginas/login.dart';
import 'package:app_turismo/Recursos/Paginas/menu.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Turismo App Administrador',
        theme: ThemeData(fontFamily: 'Ubuntu'),
        initialRoute: 'LoginF',
        routes: {
          'SplashScreen': (BuildContext context) => SplashScreen(),
          'LoginF': (BuildContext context) => LoginF(),
          'Menu' : (BuildContext context) => Menu()
        },
    );
  }
}
