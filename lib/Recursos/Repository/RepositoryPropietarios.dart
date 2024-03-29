import 'dart:io';

import 'package:app_turismo/Recursos/Models/PropietarioModel.dart';

abstract class MyPropietarioRepository {
  String newId();
  Future<void> saveMyPropietario(Propietario mySite);
  Future<void> editMyPropietarios(Propietario mySite);
  Future<void> deleteMyPropietario(Propietario mySite);
  Future<void> informationUser();
  Future<void> saveImageProfile();
}
