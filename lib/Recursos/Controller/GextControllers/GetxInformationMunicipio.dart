import 'dart:async';
import 'package:app_turismo/Recursos/Controller/GextControllers/GetxConnectivity.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GextUtils.dart';
import 'package:app_turismo/Recursos/Models/InfoMunicipio.dart';
import 'package:app_turismo/Recursos/Repository/GestionRepository.dart';
import 'package:app_turismo/Recursos/Repository/implementation/RepositoryGestionImp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetxInformationMunicipio extends GetxController {
  final MyGestionRepository _repositoryMunicipio = MyRepositoryGestionImp();
  final GetxUtils messageController = Get.put(GetxUtils());
  final ConnectivityController connectivityController = Get.put(ConnectivityController());

  late Stream<QuerySnapshot> informationStream;

  final tituloControl = TextEditingController();
  final descriptionControl = TextEditingController();

  Rx<bool> isSaveInformation = Rx(true);
  Rx<bool> isUpdateInformation = Rx(true);
  Rx<bool> infoExists = Rx(true);

  List<String> listUrlPhotosFirebase = <String>[].obs;
  List<dynamic> listCroppedFile = <dynamic>[].obs;
  List<dynamic> listPhotosCarousel = <dynamic>[].obs;
  List<Widget> listWidget = <Widget>[].obs;

  var buttonTextSave = "Guardar".obs;
  var titleAppbar = "Registro titulo".obs;

  Rx<bool> infoMainVisible = Rx(true);
  Rx<bool> infoSubVisible = Rx(true);

  late InfoMunicipio infoMunicipioUpdate;
  int indexUpdate = 0;

  int _countTapItem = 0;
  int get countTapItem => _countTapItem;
  String tipoGestion = "";
  String uuidInfoSitio = "";

  void updateTypeGestion(String typeValue) {
    tipoGestion = typeValue;
    update();
  }

  /**
   * Funcion que recibe desde la lista informacion que se va actualizar,
   * titulo pricipal o subinformacion con su respectivo index.
   * Muestra informacion en los formularios, para actualizar igual las fotografias
   * ya existentes en la base de datos de firebase.
   */
  updateInforMunicipio(InfoMunicipio infoMunicipio, int index) {
    infoMunicipioUpdate = infoMunicipio;
    indexUpdate = index;

    if (index != -1) {
      tituloControl.text = infoMunicipio.subTitulos[index].titulo;
      descriptionControl.text = infoMunicipio.subTitulos[index].descripcion;
      listUrlPhotosFirebase = infoMunicipio.subTitulos[index].listPhotosPath!.isEmpty
          ? []
          : infoMunicipio.subTitulos[index].listPhotosPath!
              .where((element) => element is String)
              .map((element) => element.toString())
              .toList();
      titleAppbar.value = "Actualizacion Subtitulos";
    } else {
      tituloControl.text = infoMunicipio.nombre;
      descriptionControl.text = infoMunicipio.descripcion;
      listUrlPhotosFirebase = infoMunicipio.photos.isEmpty
          ? []
          : infoMunicipio.photos
              .where((element) => element is String)
              .map((element) => element.toString())
              .toList();
      titleAppbar.value = "Actualizacion Titulo";
    }

    isSaveInformation.value = false;
    isUpdateInformation.value = true;
    buttonTextSave.value = "Actualizar";
    update();
  }

  cleanForm() {
    tituloControl.clear();
    descriptionControl.clear();
    listUrlPhotosFirebase.clear();
    listCroppedFile.clear();
    listPhotosCarousel.clear();
    listWidget.clear();
    update();
  }

  String uuidGenerate() {
    return _repositoryMunicipio.newId();
  }

  Future<void> saveInformation(InfoMunicipio infoMunicipio) async {
    buttonTextSave.value = "Agregando...";
    await _repositoryMunicipio.saveInformationMunicipality(infoMunicipio).then((value) {
      buttonTextSave.value = "Agregar";
      messageController.messageInfo("Informacion", "Titulo agregado.");
    });
    cleanForm();
  }

  Future<void> updateInformation() async {
    buttonTextSave.value = "Actualizando";

    await _repositoryMunicipio
        .updateInformationMunicipality(infoMunicipioUpdate, indexUpdate)
        .then((value) => {
              messageController.messageInfo(
                  "Actualizacion", "Se actualizaron los datos correctamente.")
            })
        .onError((error, stackTrace) =>
            {messageController.messageWarning("Actualizacion", "Error inesperado")});

    cleanForm();
    buttonTextSave.value = "Actualizar";
    update();
  }

  bool validateInformationEquals() {
    bool result = false;
    if (tituloControl.text != infoMunicipioUpdate.nombre ||
        descriptionControl.text != infoMunicipioUpdate.descripcion ||
        listCroppedFile.length > 0) {

      if (indexUpdate == -1) { //TODO: Actualiza el titulo
        infoMunicipioUpdate.nombre = tituloControl.text;
        infoMunicipioUpdate.descripcion = descriptionControl.text;
        infoMunicipioUpdate.photos.addAll(listCroppedFile);
      } else {
        //TODO: Actualiza un subtitle.
        infoMunicipioUpdate.subTitulos[indexUpdate].titulo = tituloControl.text;
        infoMunicipioUpdate.subTitulos[indexUpdate].descripcion = descriptionControl.text;
        infoMunicipioUpdate.subTitulos[indexUpdate].listPhotosPath?.addAll(listCroppedFile);
      }
      result = true;
    } else {
      messageController.messageWarning("Informacion", "No existen cambios por actualizar.");
    }

    return result;
  }

  Stream<QuerySnapshot> listInfo() {
    final Stream<QuerySnapshot> _informationStream = FirebaseFirestore.instance
        .collection('dataTurismo')
        .where('subCategoria', isEqualTo: tipoGestion)
        .snapshots();

    this.informationStream = _informationStream;
    informationStream.listen((QuerySnapshot snapshot) {
      if (snapshot.docs.isEmpty) {
        tituloControl.text = "";
        descriptionControl.text = "";
      }
    }, onError: (error) {
      print('Error en el stream: $error');
      messageController.messageError("Error", "Error desconocido: ${error.toString()}");
    });

    return _informationStream;
  }

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

  void updateTapItem(int posicion) {
    _countTapItem = posicion;
    update();
  }

  Future<void> deleteInformation(String? documentId, int mapIndex, String urlImage) async {
    _repositoryMunicipio.deleteMyGestion(documentId, mapIndex, urlImage);
  }

  Future<void> deleteMapFromList(String documentId, int mapIndex) async {
    await _repositoryMunicipio.deleteMapFromList(documentId, mapIndex).then((value) {
      messageController.messageInfo("Informacion", "Borrado correcto.");
    }).onError((error, stackTrace) {
      messageController.messageInfo("Error", "Ups! Ocurrio un error. Vuelve a intentar");
    });
  }
}
