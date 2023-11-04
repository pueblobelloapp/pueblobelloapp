import 'package:app_turismo/Recursos/Paginas/Login.dart';
import 'package:app_turismo/Recursos/Paginas/ModuleMunicipio/ListMunicipality.dart';
import 'package:app_turismo/Recursos/Paginas/ModuleMunicipio/RegisterMunicipality.dart';
import 'package:app_turismo/Recursos/Paginas/ModuleTouristSite/ListTouristSite.dart';
import 'package:app_turismo/Recursos/Paginas/Register.dart';
import 'package:app_turismo/Recursos/Paginas/SplashScreen.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/RecoverPassword.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/TouristSiteOwner.dart';
import 'package:app_turismo/Recursos/SystemNavegation/Bindings.dart';
import 'package:get/get.dart';

import '../../Paginas/ModuleTouristSite/RegisterTouristSite.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: Routes.Login, page: () => Login(), bindings: [LoginBinding(), UtilGetxBinding()]),
    GetPage(
        name: Routes.Register,
        page: () => Registrar(),
        bindings: [LoginBinding(), UtilGetxBinding()]),
    GetPage(
        name: Routes.ResetPassword,
        page: () => RecoverPassword(),
        bindings: [LoginBinding(), UtilGetxBinding()]),
    GetPage(
        name: Routes.RegisterSites,
        page: () => RegisterTouristSite(),
        bindings: [RegisterSitesBinding(), UtilGetxBinding()]),
    GetPage(
        name: Routes.RegisterMunicipality,
        page: () => RegisterMunicipality(),
        bindings: [InformationMunicipalityBinding(), ImageUploadBinding(), UtilGetxBinding()]),
    GetPage(name: Routes.TouristSiteOwner, page: () => TouristSiteOwner(), bindings: [
      UtilGetxBinding(),
    ]),
    GetPage(
      name: Routes.SplashScreen,
      page: () => SplashScreen(),
    ),
    GetPage(name: Routes.ListSitesTourist, page: (() => ListSitesTourist())),
    GetPage(
        name: Routes.ListMunicipality,
        page: (() => ListMunicipality()),
        bindings: [
          InformationMunicipalityBinding(),
          UtilGetxBinding(),
          ConnectivityBinding()
        ]
    ),
  ];
}
