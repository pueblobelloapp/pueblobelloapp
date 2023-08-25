import 'dart:io';

import 'package:app_turismo/Recursos/DataSource/FirebaseGestion.dart';
import 'package:app_turismo/Recursos/Models/InfoMunicipio.dart';
import 'package:app_turismo/Recursos/Repository/GestionRepository.dart';
import 'package:app_turismo/main.dart';

class MyRepositoryGestionImp extends MyGestionRepository {
  final GestionDataBase _gestionDataBase = getIt();

  @override
  Future<void> deleteMyGestion(String uid, String module) async {
    // TODO: implement deleteMyCultura
    _gestionDataBase.deleteInformation(uid, module);
  }

  @override
  Future<void> editMyGestion(InfoMunicipio myGestion) {
    // TODO: implement editMyCultura
    throw UnimplementedError();
  }

  @override
  Stream<Iterable<InfoMunicipio>> getMyGestion() {
    // TODO: implement getMyCulture
    throw UnimplementedError();
  }

  @override
  String newId() {
    // TODO: implement newId
    return _gestionDataBase.newId();
  }

  @override
  Future<void> saveMyGestion(InfoMunicipio myGestion) {
    // TODO: implement saveMyCultura
    return _gestionDataBase.saveGestion(myGestion);
  }
}
