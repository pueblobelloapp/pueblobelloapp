import 'dart:async';

import 'package:app_turismo/Recursos/Controller/GextControllers/GetxSitioTuristico.dart';
import 'package:app_turismo/Recursos/Models/SiteTuristico.dart';
import 'package:app_turismo/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../Repository/RepositorySiteTuristico.dart';
import 'GextControllers/GexTurismo.dart';

class EditSitesController extends GetxController {
  final MySitesRepository _mySitesRepository = getIt();

  Rx<bool> isLoading = Rx(false);

  // When we are editing _toEdit won't be null
  SitioTuristico? _toEdit;

  // This function will be called from the presentation layer
  // when the user has to be saved
  Future<void> saveSite(String nombre, String capacidad, String tipoTurismo,
      String descripcion, String ubicacion, String uidUser) async {
    isLoading.value = true;

    // If we are editing, we use the existing id. Otherwise, create a new one.
    final uid = _mySitesRepository.newId();
    _toEdit = SitioTuristico(
        id: uid,
        nombre: nombre,
        capacidad: capacidad,
        tipoTurismo: tipoTurismo,
        descripcion: descripcion,
        ubicacion: ubicacion,
        userId: uidUser);

    print("Agregar datos: " + _toEdit.toString());
    await _mySitesRepository.saveMySite(_toEdit!);
    isLoading.value = false;

    Get.showSnackbar(const GetSnackBar(
      title: 'Validacion de sitio',
      message: 'agregado correctamente',
      icon: Icon(Icons.add),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.green,
    ));
  }

  Future<void> editSite(
      String uid,
      String nombre,
      String capacidad,
      String tipoTurismo,
      String descripcion,
      String ubicacion,
      String uidUser,
      List<dynamic>? fotos
      ) async {
    isLoading.value = true;

    _toEdit = SitioTuristico(
        id: uid,
        nombre: nombre,
        capacidad: capacidad,
        tipoTurismo: tipoTurismo,
        descripcion: descripcion,
        ubicacion: ubicacion,
        userId: uidUser,
        foto: fotos
    );

    print("Actualizacion datos: " + _toEdit.toString());
    await _mySitesRepository.saveMySite(_toEdit!);
    isLoading.value = false;
  }

  Stream<QuerySnapshot> getSitesUser() {
    return _mySitesRepository.getSitesUid();
  }
}
