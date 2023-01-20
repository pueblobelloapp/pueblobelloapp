import 'dart:async';
import 'dart:io';

import 'package:app_turismo/Recursos/Models/GestionModel.dart';
import 'package:app_turismo/Recursos/Repository/GestionRepository.dart';
import 'package:app_turismo/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditGestionController extends GetxController {

  final MyGestionRepository _myCulturaRepository = getIt();

  // Reactive variables that will hold the state of this GetxController
  Rx<File?> pickedImage = Rx(null);
  Rx<bool> isLoading = Rx(false);

  // When we are editing _toEdit won't be null
  GestionModel? _toEdit;

  EditGestionController(this._toEdit);

  // This function will be called from the presentation layer
  // when an image is selected
  void setImage(File? imageFile) async {
    pickedImage.value = imageFile;
  }

  // This function will be called from the presentation layer
  // when the user has to be saved
  Future<void> saveGestion(
      String nombre,
      String descripcion,
      String ubicacion
      ) async {
    isLoading.value = true;

    // If we are editing, we use the existing id. Otherwise, create a new one.
    final uid = _myCulturaRepository.newId();
    _toEdit = GestionModel(
        id: uid,
        nombre: nombre,
        descripcion: descripcion,
        ubicacion: ubicacion,
        foto : _toEdit?.foto);

    await _myCulturaRepository.saveMyGestion(_toEdit!, pickedImage.value);
    isLoading.value = false;

    Get.showSnackbar(const GetSnackBar(
      title: 'Informacion',
      message: 'Registro guardado',
      icon: Icon(Icons.add),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.green,
    ));
  }

  Future<void> editGestion(
      String uid,
      String nombre,
      String descripcion,
      String ubicacion
      ) async {
    isLoading.value = true;

    _toEdit = GestionModel(
        id: uid,
        nombre: nombre,
        descripcion: descripcion,
        ubicacion: ubicacion,
        foto : _toEdit?.foto);

    await _myCulturaRepository.saveMyGestion(_toEdit!, pickedImage.value);
    isLoading.value = false;
  }
}
