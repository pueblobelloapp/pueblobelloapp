import 'dart:async';
import 'package:app_turismo/Recursos/Models/InfoMunicipio.dart';
import 'package:app_turismo/Recursos/Models/SubInfoMunicipio.dart';
import 'package:app_turismo/Recursos/Repository/GestionRepository.dart';
import 'package:app_turismo/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'GetxSitioTuristico.dart';

class GetxInformationMunicipio extends GetxController {
  final MyGestionRepository _myCulturaRepository = getIt();

  final tituloControl = TextEditingController();
  final descriptionControl = TextEditingController();
  final subTituloControl = TextEditingController();
  final subDescriptionControl = TextEditingController();

  final GetxSitioTuristico getxSitioTuristico = Get.put(GetxSitioTuristico());

  Rx<bool> isLoading = Rx(false);

  List<SubInfoMunicipio> listSubInformation = [];

  addSubinformation(SubInfoMunicipio infoMunicipio) {
    print("Fotos tamaño:" + getxSitioTuristico.listCroppedFile.length.toString());

    infoMunicipio = infoMunicipio.copyWith(
        listPhotos: getxSitioTuristico.listCroppedFile, photos: []);
    listSubInformation.add(infoMunicipio);
    update();
  }

  // This function will be called from the presentation layer
  // when the user has to be saved
  Future<void> saveGestion(InfoMunicipio infoMunicipio) async {
    isLoading.value = true;

    final uid = _myCulturaRepository.newId();

    infoMunicipio = infoMunicipio.copyWith(
        id: uid,
        ubicacion: getxSitioTuristico.mapUbications,
        subTitulos: listSubInformation
    );

    print(infoMunicipio.toString());
    await _myCulturaRepository.saveMyGestion(infoMunicipio);
    isLoading.value = false;
  }

  Future<void> editGestion(String uid, String nombre, String descripcion,
      String ubicacion, List<SubInfoMunicipio> subTitulos) async {
    isLoading.value = true;

    InfoMunicipio _toEdit = InfoMunicipio(
        id: uid,
        nombre: nombre,
        descripcion: descripcion,
        ubicacion: getxSitioTuristico.mapUbications,
        subTitulos: subTitulos);

    await _myCulturaRepository.saveMyGestion(_toEdit!);
    isLoading.value = false;
  }


}
