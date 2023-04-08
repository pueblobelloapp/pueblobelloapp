import 'dart:async';
import 'dart:io';

import 'package:app_turismo/Recursos/Models/PropietarioModel.dart';
import 'package:app_turismo/Recursos/Repository/RepositoryPropietarios.dart';
import 'package:app_turismo/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PropietarioController extends GetxController {

  final MyPropietarioRepository _myPropietarioRepository = getIt();

  Propietario? _toEdit;

  XFile? _imagePerfil;
  Rx<bool> isLoading = Rx(false);

  XFile? get imagePerfil => _imagePerfil;

  void setImage(XFile? imageFile) async {
    _imagePerfil = imageFile;
    update();
  }

  Future<void> savePropietario(
      String uidPropietario,
      String nombre,
      String rool,
      String edad,
      String genero,
      String correo,
      String contacto,
      ) async {
    isLoading.value = true;

    _toEdit = Propietario(
        id: uidPropietario,
        rool: rool,
        nombre: nombre,
        edad: edad,
        genero: genero,
        correo: correo,
        contacto : contacto,
        foto : _toEdit?.foto);

    await _myPropietarioRepository.saveMyPropietario(_toEdit!);
    isLoading.value = false;
  }

  Future<void> editSite(
      String uid,
      String rool,
      String nombre,
      String edad,
      String genero,
      String correo,
      String contacto,
      ) async {
    isLoading.value = true;

    _toEdit = Propietario(
        id: uid,
        rool: rool ,
        nombre: nombre,
        edad: edad,
        genero: genero,
        correo: correo,
        contacto : contacto,
        foto : _toEdit?.foto);

    await _myPropietarioRepository.saveMyPropietario(_toEdit!);
    isLoading.value = false;
  }

  Future<void> informationUser() async {
    await _myPropietarioRepository.informationUser();
  }
}
