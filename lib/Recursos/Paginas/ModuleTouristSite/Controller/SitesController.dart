import 'dart:async';

import 'package:app_turismo/Recursos/Models/SiteTuristico.dart';
import 'package:app_turismo/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Repository/RepositorySiteTuristico.dart';

class EditSitesController extends GetxController {
  final MySitesRepository _mySitesRepository = getIt();

  Rx<bool> isLoading = Rx(false);

  Future<void> saveSite(SitioTuristico sitioTuristico) async {
    isLoading.value = true;
    final newIdDocument = _mySitesRepository.newId();
    sitioTuristico = sitioTuristico.copyWith(id: newIdDocument);
    print("Agregar datos: " + sitioTuristico.toString());
    await _mySitesRepository.saveMySite(sitioTuristico);
    isLoading.value = false;
  }

  Future<void> editSite(SitioTuristico sitioTuristico) async {
    isLoading.value = true;
    print("Actualizacion datos: " + sitioTuristico.toString());
    await _mySitesRepository.saveMySite(sitioTuristico);
    isLoading.value = false;
  }

  Stream<QuerySnapshot> getSitesUser() {
    return _mySitesRepository.getSitesUid();
  }

  Stream<QuerySnapshot> getAvtivity() {
    return _mySitesRepository.getAvtivity();
  }
}
