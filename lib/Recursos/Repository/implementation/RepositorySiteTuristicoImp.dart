
import 'dart:io';

import 'package:app_turismo/Recursos/Models/SiteTuristico.dart';
import 'package:app_turismo/Recursos/Repository/RepositorySiteTuristico.dart';
import '../../../main.dart';
import '../../DataSource/FirebaseSites.dart';

class MyRepositorySiteTuristicoImp extends MySitesRepository {
  final SiteTuristicoDataSource _siteTuristicoDataSource = getIt();

  @override
  Future<void> deleteMySite(SitioTuristico mySite) {
    // TODO: implement deleteMySite
    throw UnimplementedError();
  }

  @override
  Stream<Iterable<SitioTuristico>> getMySite() {
    // TODO: implement getMySite
    throw UnimplementedError();
  }

  @override
  String newId() {
    // TODO: implement newId
    return _siteTuristicoDataSource.newId();
  }

  @override
  Future<void> saveMySite(SitioTuristico mySite, File? image) {
    return _siteTuristicoDataSource.saveMySite(mySite, image);
  }

  @override
  Future<void> editMySite(SitioTuristico mySite, File? image) {
    // TODO: implement editMySite
    throw UnimplementedError();
  }

}