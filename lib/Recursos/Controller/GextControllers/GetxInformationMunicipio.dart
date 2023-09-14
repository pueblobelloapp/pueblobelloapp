import 'dart:async';
import 'package:app_turismo/Recursos/Models/InfoMunicipio.dart';
import 'package:app_turismo/Recursos/Repository/GestionRepository.dart';
import 'package:app_turismo/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';

class GetxInformationMunicipio extends GetxController {
  final MyGestionRepository _myCulturaRepository = getIt();

  late Stream<QuerySnapshot> informationStream;

  final formKey = GlobalKey<FormState>();
  final formKeySub = GlobalKey<FormState>();

  final tituloControl = TextEditingController();
  final descriptionControl = TextEditingController();
  final subTituloControl = TextEditingController();
  final subDescriptionControl = TextEditingController();

  Rx<bool> isLoading = Rx(false);
  Rx<bool> isSaveOrUpdate = Rx(true);

  List<CroppedFile> listPhotosInfo = [];
  List<CroppedFile> listPhotosSubInfo = [];
  List<SubTitulo> listSubInformation = [];
  List<String> listPhotosUrls = <String>[].obs;
  List<dynamic> listPhotosSubUrls = [];

  var buttonTextSave = "Guardar".obs;

  late InfoMunicipio infoMunicipioUpdate;
  int indexUpdateMunicipio = 0;

  int _countTapItem = 0;
  int get countTapItem => _countTapItem;
  String tipoGestion = "";

  void updateList(List<String> newData) {
    listPhotosUrls.assignAll(newData);
  }

  updateInforMunicipio(InfoMunicipio infoMunicipio, int indexSubtitulo) {
    print("Index Actualizar: ${indexSubtitulo}");
    infoMunicipioUpdate = infoMunicipio;
    indexUpdateMunicipio = indexSubtitulo;

    subTituloControl.text = infoMunicipio.subTitulos[indexSubtitulo].titulo;
    subDescriptionControl.text = infoMunicipio.subTitulos[indexSubtitulo].descripcion;
    listPhotosSubUrls = infoMunicipio.subTitulos[indexSubtitulo].listPhotosPath!
        .where((element) => element is String)
        .map((element) => element.toString())
        .toList();

    buttonTextSave.value = "Actualizar";
    update();
  }

  addSubinformation() {
    SubTitulo subInfoMunicipio = SubTitulo(
        titulo: subTituloControl.text,
        descripcion: subDescriptionControl.text,
        listPhotosPath: List.from(listPhotosSubInfo));

    listSubInformation.add(subInfoMunicipio);
    cleanSubInfo();
    update();
  }

  cleanSubInfo() {
    subTituloControl.text = "";
    subDescriptionControl.text = "";
    listPhotosSubInfo.clear();
  }

  cleanForm() {
    cleanSubInfo();
    descriptionControl.text = "";
    tituloControl.text = "";
    listPhotosInfo.clear();
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

  Future<void> saveGestion(InfoMunicipio infoMunicipio) async {
    isLoading.value = false;
    await _myCulturaRepository.saveMyGestion(infoMunicipio);
    cleanForm();
    isLoading.value = true;
  }
  
  Future<void> updateGestion(InfoMunicipio infoMunicipio) async {
    isLoading.value = false;
    await _myCulturaRepository.editMyGestion(infoMunicipio);
    cleanForm();
    isLoading.value = true;
  }

  Stream<QuerySnapshot> listInfo() {
    final Stream<QuerySnapshot> _informationStream = FirebaseFirestore.instance
        .collection('dataTurismo')
        .where('subCategoria', isEqualTo: tipoGestion)
        .snapshots();

    this.informationStream = _informationStream;
    informationStream.listen((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final List<DocumentSnapshot> documents = snapshot.docs;
        for (var document in documents) {
          final data = document.data() as Map<String, dynamic>;
          tituloControl.text = data['nombre'];
          descriptionControl.text = data['descripcion'];
          List<String> newData = (data['photos'] as List?)?.whereType<String>().toList() ?? [];
          updateList(newData);
        }
      } else {
        cleanForm();
      }
    }, onError: (error) {
      print('Error en el stream: $error');
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

  //Funcion para determinar la posicion del tapIndex
  void updateTapItem(int posicion) {
    _countTapItem = posicion;
    update();
  }
}
