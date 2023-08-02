import 'dart:async';
import 'dart:io';

import 'package:app_turismo/Recursos/Models/GestionModel.dart';
import 'package:app_turismo/Recursos/Repository/GestionRepository.dart';
import 'package:app_turismo/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditGestionController extends GetxController {

  final MyGestionRepository _myCulturaRepository = getIt();

  Rx<bool> isLoading = Rx(false);

  // When we are editing _toEdit won't be null
  GestionModel? _toEdit;

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
        ubicacion: ubicacion);

    await _myCulturaRepository.saveMyGestion(_toEdit!);
    isLoading.value = false;
  }

  Future<void> editGestion(
      String uid,
      String nombre,
      String descripcion,
      String ubicacion,
      ) async {
    isLoading.value = true;

    _toEdit = GestionModel(
        id: uid,
        nombre: nombre,
        descripcion: descripcion,
        ubicacion: ubicacion);

    await _myCulturaRepository.saveMyGestion(_toEdit!);
    isLoading.value = false;
  }

  Future<void> deleteInformation(String uid, String module) async {
    await _myCulturaRepository.deleteMyGestion(uid, module);
  }
}
