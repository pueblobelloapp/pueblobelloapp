import 'package:app_turismo/Recursos/Paginas/Menu.dart';
import 'package:app_turismo/Recursos/Paginas/SplashScreen.dart';
import 'package:app_turismo/Recursos/Paginas/login.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/ListaInformacion.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/ModuleGestion.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/NavegacionGestion.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/NavegacionPropietario.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/ModulePropietario.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/mSitiosTuristico.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Turismo App Administrador',
      theme: ThemeData(fontFamily: 'Ubuntu', primaryColor: Colors.green),
      initialRoute: 'LoginF',
      routes: {
        'SplashScreen' : (BuildContext context) => SplashScreen(),
        'LoginF' : (BuildContext context) => LoginF(),
        'Menu' : (BuildContext context) => MenuModuls(),
        'ModuleSitios' : (BuildContext context) => MsitiosTuristico(),
        'Lista' : (BuildContext context) => ListInformationGestion(),
        'MenuGestion' : (BuildContext context) => NavegacionGestion(),
        'MenuPropietario' : (BuildContext context) => NavegacionPropietario()
      },
    );
  }
}
