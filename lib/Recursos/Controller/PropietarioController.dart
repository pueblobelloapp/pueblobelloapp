import 'dart:async';
import 'dart:io';

import 'package:app_turismo/Recursos/Models/PropietarioModel.dart';
import 'package:app_turismo/Recursos/Repository/RepositoryPropietarios.dart';
import 'package:app_turismo/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PropietarioController extends GetxController {

  final MyPropietarioRepository _myPropietarioRepository = getIt();

  Rx<File?> pickedImage = Rx(null);
  Rx<bool> isLoading = Rx(false);

  Propietario? _toEdit;
  PropietarioController(this._toEdit);


  void setImage(File? imageFile) async {
    pickedImage.value = imageFile;
  }

  Future<void> savePropietario(
      String nombre,
      String sitioturistico,
      String edad,
      String genero,
      String correo,
      String contacto,
      ) async {
    isLoading.value = true;

    // If we are editing, we use the existing id. Otherwise, create a new one.
    final uid = _myPropietarioRepository.newId();
    _toEdit = Propietario(
        id: uid,
        nombre: nombre,
        edad: edad,
        genero: genero,
        correo: correo,
        contacto : contacto,
        foto : _toEdit?.foto);

    await _myPropietarioRepository.saveMyPropietario(_toEdit!, pickedImage.value);
    isLoading.value = false;

    Get.showSnackbar(const GetSnackBar(
      title: 'Validacion de propietario',
      message: 'agregado correctamente',
      icon: Icon(Icons.add),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.green,
    ));
  }

  Future<void> editSite(
      String uid,
      String nombre,
      String edad,
      String genero,
      String correo,
      String contacto,
      ) async {
    isLoading.value = true;

    _toEdit = Propietario(
        id: uid,
        nombre: nombre,
        edad: edad,
        genero: genero,
        correo: correo,
        contacto : contacto,
        foto : _toEdit?.foto);

    await _myPropietarioRepository.saveMyPropietario(_toEdit!, pickedImage.value);
    isLoading.value = false;

  }



















}