import 'dart:io';

import 'package:app_turismo/Recursos/DataSource/FirebaseGestion.dart';
import 'package:app_turismo/Recursos/Models/GestionModel.dart';
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
  Future<void> editMyGestion(GestionModel myGestion) {
    // TODO: implement editMyCultura
    throw UnimplementedError();
  }

  @override
  Stream<Iterable<GestionModel>> getMyGestion() {
    // TODO: implement getMyCulture
    throw UnimplementedError();
  }

  @override
  String newId() {
    // TODO: implement newId
    return _gestionDataBase.newId();
  }

  @override
  Future<void> saveMyGestion(GestionModel myGestion) {
    // TODO: implement saveMyCultura
    return _gestionDataBase.saveGestion(myGestion);
  }

}