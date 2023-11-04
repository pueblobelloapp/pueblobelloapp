import 'package:app_turismo/Recursos/Controller/LoginController.dart';
import 'package:app_turismo/Recursos/DataSource/FirebaseGestion.dart';
import 'package:app_turismo/Recursos/DataSource/FirebasePropietario.dart';
import 'package:app_turismo/Recursos/Repository/GestionRepository.dart';
import 'package:app_turismo/Recursos/Repository/RepositoryPropietarios.dart';
import 'package:app_turismo/Recursos/Repository/RepositorySiteTuristico.dart';
import 'package:app_turismo/Recursos/Repository/autenticacion.dart';
import 'package:app_turismo/Recursos/Repository/implementation/RepositoryGestionImp.dart';
import 'package:app_turismo/Recursos/Repository/implementation/RepositoryPropietariosImp.dart';
import 'package:app_turismo/Recursos/Repository/implementation/RepositorySiteTuristicoImp.dart';
import 'package:app_turismo/Recursos/Repository/implementation/auth_repository.dart';
import 'package:app_turismo/Recursos/Widgets/carousel_photos.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'Recursos/Controller/GextControllers/GetxManagementMunicipality.dart';
import 'Recursos/Controller/GextControllers/GetxManagementTouristSite.dart';
import 'Recursos/Controller/GextControllers/GextUtils.dart';
import 'Recursos/Controller/GextControllers/GextPropietarioController.dart';
import 'Recursos/DataSource/FirebaseSites.dart';
import 'Recursos/Paginas/MyApp.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await injectDependencies();
  Get.put(SiteTuristicoDataSource());
  Get.put(ControllerLogin());
  Get.put(CarouselPhotos());
  runApp(const MyApp());
}

Future<void> injectDependencies() async {
  //Controladores
  getIt.registerLazySingleton(() => GetxManagementTouristSite());
  getIt.registerLazySingleton(() => GextPropietarioController());
  getIt.registerLazySingleton(() => ManagementMunicipalityController());

  // Data sources
  getIt.registerLazySingleton(() => GestionDataBase());
  getIt.registerLazySingleton(() => SiteTuristicoDataSource());
  getIt.registerLazySingleton(() => PropietarioDataBase());

  getIt.registerLazySingleton(() => GetxUtils());

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImp());
  getIt.registerLazySingleton<MyGestionRepository>(() => MyRepositoryGestionImp());
  getIt.registerLazySingleton<MySitesRepository>(() => MyRepositorySiteTuristicoImp());
  getIt.registerLazySingleton<MyPropietarioRepository>(() => MyPropietarioImp());
}
