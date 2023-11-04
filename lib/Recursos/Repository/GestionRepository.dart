import 'package:app_turismo/Recursos/Models/InfoMunicipio.dart';
import 'dart:io';

abstract class MyGestionRepository {
  String newId();
  Stream<Iterable<InfoMunicipio>> getMyGestion();
  Future<void> saveInformationMunicipality(InfoMunicipio modelGestion);
  Future<void> updateInformationMunicipality(InfoMunicipio modelGestion, int index);
  Future<void> editMyGestion(
      InfoMunicipio modelGestion, int index, List<String> photosSub, List<String> photosMain);
  Future<void> deleteMyGestion(String? documentId, int mapIndex, String urlImage);
  Future<void> deleteMapFromList(String documentId, int mapIndex);
}
