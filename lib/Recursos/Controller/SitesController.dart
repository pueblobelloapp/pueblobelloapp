import 'dart:async';
import 'dart:io';

import 'package:app_turismo/Recursos/Models/SiteTuristico.dart';
import 'package:app_turismo/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';

import '../Repository/RepositorySiteTuristico.dart';

class EditSitesController extends GetxController {

  final MySitesRepository _mySitesRepository = getIt();

  // Reactive variables that will hold the state of this GetxController
  Rx<File?> pickedImage = Rx(null);
  Rx<bool> isLoading = Rx(false);

  // When we are editing _toEdit won't be null
  SitioTuristico? _toEdit;

  EditSitesController(this._toEdit);

  // This function will be called from the presentation layer
  // when an image is selected
  void setImage(File? imageFile) async {
    pickedImage.value = imageFile;
  }

  // This function will be called from the presentation layer
  // when the user has to be saved
  Future<void> saveSite(
      String nombre,
      String capacidad,
      String tipoTurismo,
      String descripcion,
      String ubicacion,
      String uidUser
      ) async {
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
        userId: uidUser,
        foto : _toEdit?.foto);

    await _mySitesRepository.saveMySite(_toEdit!, pickedImage.value);
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
      String uidUser
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
        foto : _toEdit?.foto);

    await _mySitesRepository.saveMySite(_toEdit!, pickedImage.value);
    isLoading.value = false;

  }
}
