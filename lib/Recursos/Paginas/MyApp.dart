import 'package:app_turismo/Recursos/Paginas/SplashScreen.dart';
import 'package:app_turismo/Recursos/Paginas/login.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/mCultura.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/mFestividad.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/mGastronom%C3%ADa.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/mPropietario.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/mReligion.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/mSitiosTuristico.dart';
import 'package:app_turismo/Recursos/Paginas/menu.dart';
import 'package:app_turismo/Recursos/Paginas/registrar.dart';

//import 'package:app_turismo/Recursos/Paginas/welcomePages.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Turismo App Administrador',
        theme: ThemeData(fontFamily: 'Ubuntu'),
        initialRoute: 'LoginF',
        routes: {
          'SplashScreen': (BuildContext context) => SplashScreen(),
          'LoginF': (BuildContext context) => LoginF(),
        },
      ),
    );
  }
}
