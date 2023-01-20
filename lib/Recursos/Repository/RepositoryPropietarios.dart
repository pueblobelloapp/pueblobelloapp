

import 'dart:io';

import 'package:app_turismo/Recursos/Models/PropietarioModel.dart';

abstract class MyPropietarioRepository {

  String newId();
  Stream<Iterable<Propietario>> getMyPropietario();
  Future<void> saveMyPropietario(Propietario mySite, File? image);
  Future<void> editMyPropietarios(Propietario mySite, File? image);
  Future<void> deleteMyPropietario(Propietario mySite);

}
