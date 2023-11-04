import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app_turismo/Recursos/DataSource/FirebaseGestion.dart';
import 'package:app_turismo/Recursos/Models/InfoMunicipio.dart';
import 'package:app_turismo/Recursos/Repository/GestionRepository.dart';
import 'package:app_turismo/main.dart';

class MyRepositoryGestionImp extends MyGestionRepository {
  final GestionDataBase _gestionDataBase = getIt();

  @override
  Future<void> editMyGestion(
      InfoMunicipio myGestion, int index, List<String> photosSub, List<String> photosMain) {
    //return _gestionDataBase.updateInformationGeneral(myGestion, index, photosSub, photosMain);
    throw UnimplementedError();
  }

  @override
  Stream<Iterable<InfoMunicipio>> getMyGestion() {
    throw UnimplementedError();
  }

  @override
  String newId() {
    return _gestionDataBase.newId();
  }

  @override
  Future<void> saveInformationMunicipality(InfoMunicipio myGestion) {
    return _gestionDataBase.saveInformation(myGestion);
  }

  @override
  Future<void> updateInformationMunicipality(InfoMunicipio infoMunicipio, int index) {
    return _gestionDataBase.updateInformation(infoMunicipio, index);
  }

  @override
  Future<void> deleteMapFromList(String documentId, int mapIndex) {
    // TODO: implement deleteMapFromList
    throw UnimplementedError();
  }

  @override
  Future<void> deleteMyGestion(String? documentId, int mapIndex, String urlString) {
    return _gestionDataBase.deletePhotoFromList(documentId!, mapIndex, urlString);
  }

}
