import 'dart:async';
import 'package:app_turismo/Recursos/Models/InfoMunicipio.dart';
import 'package:app_turismo/Recursos/Repository/GestionRepository.dart';
import 'package:app_turismo/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';

import 'GetxSitioTuristico.dart';

class GetxInformationMunicipio extends GetxController {
  final MyGestionRepository _myCulturaRepository = getIt();

  final tituloControl = TextEditingController();
  final descriptionControl = TextEditingController();
  final subTituloControl = TextEditingController();
  final subDescriptionControl = TextEditingController();
  final whyVisitControl = TextEditingController();
  final subCategoria = TextEditingController();

  Rx<bool> isLoading = Rx(false);

  List<CroppedFile> listPhotosInfo = [];
  List<CroppedFile> listPhotosSubInfo = [];
  List<SubTitulo> listSubInformation = [];

  int _countTapItem = 0;
  int get countTapItem => _countTapItem;
  String tipoGestion = "";

  addSubinformation() {
    SubTitulo subInfoMunicipio = SubTitulo(
        titulo: subTituloControl.text,
        descripcion: subDescriptionControl.text,
        listPhotosPath: List.from(listPhotosSubInfo));

    print("Info fotos " + subInfoMunicipio.listPhotosPath!.length.toString());
    listSubInformation.add(subInfoMunicipio);
    listPhotosSubInfo.clear();
    update();
  }

  addPhotosGeneral(List<CroppedFile> listPothos) {
    listPhotosInfo.addAll(listPothos);
    update();
  }

  addPhotosSub(List<CroppedFile> listPothos) {
    listPhotosSubInfo.addAll(listPothos);
    update();
  }

  String uidGenerate() => _myCulturaRepository.newId();

  // This function will be called from the presentation layer
  // when the user has to be saved
  Future<void> saveGestion(InfoMunicipio infoMunicipio) async {
    isLoading.value = true;

    print(infoMunicipio.toString());
    await _myCulturaRepository.saveMyGestion(infoMunicipio);
    isLoading.value = false;
  }

  /*Future<void> editGestion(String uid, String nombre, String descripcion,
      String ubicacion, List<SubInfoMunicipio> subTitulos) async {
    isLoading.value = true;

    */ /*InfoMunicipio _toEdit = InfoMunicipio(
        id: uid,
        nombre: nombre,
        descripcion: descripcion,
        ubicacion: getxSitioTuristico.mapUbications,
        subTitulos: subTitulos,
        listPhotos: []);*/ /*

    */ /*await _myCulturaRepository.saveMyGestion(_toEdit!);
    isLoading.value = false;*/ /*
  }*/

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Cultura"), value: "cultura"),
      DropdownMenuItem(child: Text("Etnoturismo"), value: "etnoturismo"),
      DropdownMenuItem(child: Text("Gastronomias"), value: "gastronomia"),
      DropdownMenuItem(child: Text("Festividades"), value: "fiestas"),
      DropdownMenuItem(child: Text("Religiones"), value: "religion"),
      DropdownMenuItem(child: Text("Cuenteros"), value: "cuentos"),
      DropdownMenuItem(
        child: Text("Municipio"),
        value: "municipio",
      )
    ];
    return menuItems;
  }

  //Funcion para determinar la posicion del tapIndex
  void updateTapItem(int posicion) {
    _countTapItem = posicion;
    update();
  }
}
