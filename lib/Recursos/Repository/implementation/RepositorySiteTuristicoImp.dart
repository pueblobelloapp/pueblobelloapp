import 'package:app_turismo/Recursos/Models/SiteTuristico.dart';
import 'package:app_turismo/Recursos/Repository/RepositorySiteTuristico.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/material/dropdown.dart';
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
  Future<void> saveMySite(SitioTuristico mySite) {
    return _siteTuristicoDataSource.saveMySite(mySite);
  }

  @override
  Future<void> editMySite(SitioTuristico mySite) {
    // TODO: implement editMySite
    throw UnimplementedError();
  }

  @override
  Stream<QuerySnapshot> getSitesUid() {
    // TODO: implement getSitesUid
    return _siteTuristicoDataSource.getSitesUid();
  }

  @override
  Stream<QuerySnapshot> getAvtivity() {
    return _siteTuristicoDataSource.getAvtivity();
  }
}
