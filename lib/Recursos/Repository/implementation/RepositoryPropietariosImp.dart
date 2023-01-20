
import 'dart:io';

import 'package:app_turismo/Recursos/DataSource/FirebasePropietario.dart';
import 'package:app_turismo/Recursos/Models/PropietarioModel.dart';
import 'package:app_turismo/Recursos/Repository/RepositoryPropietarios.dart';
import 'package:app_turismo/main.dart';

class MyPropietarioImp extends MyPropietarioRepository {

  final PropietarioDataBase _propietarioDataBase = getIt();

  @override
  Future<void> deleteMyPropietario(Propietario propietario) {
    // TODO: implement deleteMySite
    throw UnimplementedError();
  }

  @override
  Stream<Iterable<Propietario>> getMyPropietario() {
    // TODO: implement getMySite
    return _propietarioDataBase.getAllSites();
  }

  @override
  String newId() {
    return _propietarioDataBase.newId();
  }

  @override
  Future<void> saveMyPropietario(Propietario propietario, File? image) {
    return _propietarioDataBase.saveGestion(propietario, image);
  }

  @override
  Future<void> editMyPropietarios(Propietario mySite, File? image) {
    // TODO: implement editMyPropietarios
    throw UnimplementedError();
  }


}