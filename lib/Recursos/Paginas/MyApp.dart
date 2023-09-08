import 'package:app_turismo/Recursos/Paginas/Menu.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/MapGeolocation.dart';
import 'package:app_turismo/Recursos/Paginas/SplashScreen.dart';
import 'package:app_turismo/Recursos/Paginas/Login.dart';
import 'package:app_turismo/Recursos/Paginas/ModuleMunicipio/ListInformationMunicipio.dart';
import 'package:app_turismo/Recursos/Paginas/ModuleTouristSite/ModuleSitiosTuristico.dart';
import 'package:app_turismo/Recursos/Paginas/Navigation/NavegacionGestion.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/PerfilPropietario.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/RecuperarCuenta.dart';
import 'package:app_turismo/Recursos/theme/app_theme.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'ModuleMunicipio/InformationMunicipio.dart';
import 'Navigation/NavegacionSitioTuristico.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IKU App Administrador',
      theme: ThemeData(
          highlightColor: AppBasicColors.green,
          canvasColor: AppBasicColors.white,
          textTheme: TextTheme(
            headlineSmall: ThemeData.light()
                .textTheme
                .headlineSmall!
                .copyWith(color: AppBasicColors.green),
          ),
          iconTheme: IconThemeData(
            color: Colors.grey[600],
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: AppBasicColors.green,
            centerTitle: false,
            foregroundColor: Colors.white,
            actionsIconTheme: IconThemeData(color: Colors.white),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith(
                  (states) => AppBasicColors.green),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStateColor.resolveWith(
                (states) => AppBasicColors.green,
              ),
              side: MaterialStateBorderSide.resolveWith(
                  (states) => BorderSide(color: AppBasicColors.green)),
            ),
          ),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
              .copyWith(background: const Color(0xFFFDF5EC))),
      initialRoute: 'LoginF',
      routes: {
        'SplashScreen': (BuildContext context) => SplashScreen(),
        'LoginF': (BuildContext context) => LoginF(),
        'Menu': (BuildContext context) => MenuModuls(),
        'ModuleSitios': (BuildContext context) => ModuleSitiosTuristicos(),
        'Lista': (BuildContext context) => ListInformationMunicipio(),
        'MenuGestion': (BuildContext context) => NavegacionGestion(),
        'MenuSitioTuristico': (BuildContext context) =>
            NavegacionSitioTuristico(),
        'Propietario': (BuildContext context) => PerfilPropietario(),
        'RecoveryPass': (BuildContext context) => RecuperarPassword(),
        'GestionSites': (BuildContext context) => InformationMunicipio(),
        'MapGeolocation': (BuildContext context) => MapGeolocation(),
      },
    );
  }
}
