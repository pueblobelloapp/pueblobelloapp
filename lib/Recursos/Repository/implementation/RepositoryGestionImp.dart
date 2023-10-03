import 'dart:io';

import 'package:app_turismo/Recursos/DataSource/FirebaseGestion.dart';
import 'package:app_turismo/Recursos/Models/InfoMunicipio.dart';
import 'package:app_turismo/Recursos/Repository/GestionRepository.dart';
import 'package:app_turismo/main.dart';

class MyRepositoryGestionImp extends MyGestionRepository {
  final GestionDataBase _gestionDataBase = getIt();

  @override
  Future<void> deleteMyGestion(String uid, String module) async {
    //_gestionDataBase.deleteInformation(uid, module);
  }

  @override
  Future<void> editMyGestion(
      InfoMunicipio myGestion, int index, List<String> photosSub, List<String> photosMain) {
    return _gestionDataBase.editGestion(myGestion, index, photosSub, photosMain);
  }

  @override
  Stream<Iterable<InfoMunicipio>> getMyGestion() {
    throw UnimplementedError();
  }

  @override
  String newId() {
    return _gestionDataBase.newId();
  }

  @override
  Future<void> saveMyGestion(InfoMunicipio myGestion) {
    return _gestionDataBase.saveGestion(myGestion);
  }

  @override
  Future<void> updateInfoMain(InfoMunicipio infoMunicipio) {
    return _gestionDataBase.updateInfoMain(infoMunicipio);
  }
}
