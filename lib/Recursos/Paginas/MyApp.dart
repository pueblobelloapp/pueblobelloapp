import 'package:app_turismo/Recursos/Paginas/Menu.dart';
import 'package:app_turismo/Recursos/Paginas/SplashScreen.dart';
import 'package:app_turismo/Recursos/Paginas/Login.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/ListaInformacion.dart';
import 'package:app_turismo/Recursos/Paginas/ModuleTouristSite/ModuleSitiosTuristico.dart';
import 'package:app_turismo/Recursos/Paginas/Navigation/NavegacionGestion.dart';
import 'package:app_turismo/Recursos/Paginas/Navigation/NavegacionSitioTuristico.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/PerfilPropietario.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/RecuperarCuenta.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

import 'modulopages/ModuleGestion.dart';

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
        'SplashScreen': (BuildContext context) => SplashScreen(),
        'LoginF': (BuildContext context) => LoginF(),
        'Menu': (BuildContext context) => MenuModuls(),
        'ModuleSitios': (BuildContext context) => ModuleSitiosTuristicos(),
        'Lista': (BuildContext context) => ListInformationGestion(),
        'MenuGestion': (BuildContext context) => NavegacionGestion(),
        'MenuSitioTuristico': (BuildContext context) =>
            NavegacionSitioTuristico(),
        'Propietario': (BuildContext context) => PerfilPropietario(),
        'RecoveryPass': (BuildContext context) => RecuperarPassword(),
        'GestionSites': (BuildContext context) => ModuleGestion(),
      },
    );
  }
}
