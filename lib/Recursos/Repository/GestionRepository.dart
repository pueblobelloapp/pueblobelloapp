import 'package:app_turismo/Recursos/Models/GestionModel.dart';
import 'dart:io';

abstract class MyGestionRepository {

  String newId();
  Stream<Iterable<GestionModel>> getMyGestion();
  Future<void> saveMyGestion(GestionModel modelGestion, File? image);
  Future<void> editMyGestion(GestionModel modelGestion, File? image);
  Future<void> deleteMyGestion(GestionModel modelGestion);

}