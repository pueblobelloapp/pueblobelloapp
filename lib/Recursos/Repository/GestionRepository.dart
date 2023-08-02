import 'package:app_turismo/Recursos/Models/GestionModel.dart';
import 'dart:io';

abstract class MyGestionRepository {

  String newId();
  Stream<Iterable<GestionModel>> getMyGestion();
  Future<void> saveMyGestion(GestionModel modelGestion);
  Future<void> editMyGestion(GestionModel modelGestion);
  Future<void> deleteMyGestion(String uid, String module);

}