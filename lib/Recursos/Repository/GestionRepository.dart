import 'package:app_turismo/Recursos/Models/InfoMunicipio.dart';
import 'dart:io';

abstract class MyGestionRepository {
  String newId();
  Stream<Iterable<InfoMunicipio>> getMyGestion();
  Future<void> saveMyGestion(InfoMunicipio modelGestion);
  Future<void> editMyGestion(
      InfoMunicipio modelGestion, int index, List<String> photosSub, List<String> photosMain);
  Future<void> deleteMyGestion(String uid, String module);
}
