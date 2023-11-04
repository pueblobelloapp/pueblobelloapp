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
  String newId() {
    return _propietarioDataBase.newId();
  }

  @override
  Future<void> saveMyPropietario(Propietario propietario) {
    return _propietarioDataBase.savePropietario(propietario);
  }

  @override
  Future<void> editMyPropietarios(Propietario mySite) {
    // TODO: implement editMyPropietarios
    throw UnimplementedError();
  }

  @override
  Future<void> informationUser() async {
    // TODO: implement updateEmailPropietario
    return _propietarioDataBase.informationUser();
  }

  @override
  Future<void> saveImageProfile() async {
    // TODO: implement saveImageProfile
    return _propietarioDataBase.saveImageProfile();
  }
}
