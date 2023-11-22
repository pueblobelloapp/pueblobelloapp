import 'package:app_turismo/Recursos/Paginas/Menu.dart';
import 'package:app_turismo/Recursos/Paginas/ModuleTouristSite/ListTouristSite.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/MapGeolocation.dart';
import 'package:app_turismo/Recursos/Paginas/SplashScreen.dart';
import 'package:app_turismo/Recursos/Paginas/Login.dart';
import 'package:app_turismo/Recursos/Paginas/ModuleMunicipio/ListMunicipality.dart';
import 'package:app_turismo/Recursos/Paginas/ModuleTouristSite/RegisterTouristSite.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/PerfilPropietario.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/RecoverPassword.dart';
import 'package:app_turismo/Recursos/theme/app_theme.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'ModuleMunicipio/RegisterMunicipality.dart';
import 'Navigation/NavegacionSitioTuristico.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Turismo App Administrador',
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
        'LoginF': (BuildContext context) => Login(),
        'Menu': (BuildContext context) => MenuModuls(),
        'ModuleSitios': (BuildContext context) => RegisterTouristSite(),
        'ListInformation': (BuildContext context) => ListMunicipality(),
        'MenuSitioTuristico': (BuildContext context) => ListSitesTourist(),
        'Propietario': (BuildContext context) => PerfilPropietario(),
        'RecoveryPass': (BuildContext context) => RecoverPassword(),
        'GestionSites': (BuildContext context) => RegisterMunicipality(),
        'MapGeolocation': (BuildContext context) => MapGeolocation(),
      },
    );
  }
}
