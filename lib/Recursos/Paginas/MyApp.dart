import 'package:app_turismo/Recursos/Paginas/Menu.dart';
import 'package:app_turismo/Recursos/Paginas/SplashScreen.dart';
import 'package:app_turismo/Recursos/Paginas/login.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/ListaInformacion.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/ModuleGestion.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/ModuleGestion.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/mPropietario.dart';
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
        'ModuleCultura' : (BuildContext context) => ModuleGestion(),
        'ModulePropietario' : (BuildContext context) => Mpropietario(),
        'ModuleSitios' : (BuildContext context) => MsitiosTuristico(),
        'ModulePrueba' : (BuildContext context) => ModuleGestion(),
        'Lista' : (BuildContext context) => ListInformationGestion()
      },
    );
  }
}
