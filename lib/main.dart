import 'package:app_turismo/Recursos/Controller/LoginController.dart';
import 'package:app_turismo/Recursos/DataSource/FirebaseGestion.dart';
import 'package:app_turismo/Recursos/Repository/GestionRepository.dart';
import 'package:app_turismo/Recursos/Repository/RepositorySiteTuristico.dart';
import 'package:app_turismo/Recursos/Repository/autenticacion.dart';
import 'package:app_turismo/Recursos/Repository/implementation/RepositoryGestionImp.dart';
import 'package:app_turismo/Recursos/Repository/implementation/RepositorySiteTuristicoImp.dart';
import 'package:app_turismo/Recursos/Repository/implementation/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'Recursos/DataSource/FirebaseSites.dart';
import 'Recursos/Paginas/MyApp.dart';
import 'package:get_it/get_it.dart';

import 'firebase_options.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await injectDependencies();
  Get.put(ControllerLogin());

  runApp(const MyApp());
}

Future<void> injectDependencies() async {
  // Data sources
  getIt.registerLazySingleton(() => SiteTuristicoDataSource());
  getIt.registerLazySingleton(() => GestionDataBase());

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImp());
  getIt.registerLazySingleton<MySitesRepository>(() => MyRepositorySiteTuristicoImp());
  getIt.registerLazySingleton<MyGestionRepository>(() => MyRepositoryGestionImp());
}


