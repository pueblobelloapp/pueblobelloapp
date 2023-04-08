

import 'dart:io';

import 'package:app_turismo/Recursos/Models/PropietarioModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MyPropietarioRepository {

  String newId();
  Future<void> saveMyPropietario(Propietario mySite);
  Future<void> editMyPropietarios(Propietario mySite);
  Future<void> deleteMyPropietario(Propietario mySite);
  Future<void> informationUser();
}
