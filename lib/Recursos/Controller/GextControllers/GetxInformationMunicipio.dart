import 'dart:async';
import 'package:app_turismo/Recursos/Controller/GextControllers/GextUtils.dart';
import 'package:app_turismo/Recursos/Models/InfoMunicipio.dart';
import 'package:app_turismo/Recursos/Repository/GestionRepository.dart';
import 'package:app_turismo/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';

class GetxInformationMunicipio extends GetxController {
  final MyGestionRepository _myCulturaRepository = getIt();
  final GetxUtils messageController = Get.put(GetxUtils());

  late Stream<QuerySnapshot> informationStream;

  final formKey = GlobalKey<FormState>();
  final formKeySub = GlobalKey<FormState>();

  final tituloControl = TextEditingController();
  final descriptionControl = TextEditingController();
  final subTituloControl = TextEditingController();
  final subDescriptionControl = TextEditingController();

  Rx<bool> isLoading = Rx(false);
  Rx<bool> isSaveOrUpdate = Rx(true);
  Rx<bool> infoExists = Rx(true);

  List<CroppedFile> listPhotosInfo = <CroppedFile>[].obs;
  List<CroppedFile> listPhotosSubInfo = <CroppedFile>[].obs;
  List<SubTitulo> listSubInformation = [];
  List<String> listPhotosUrls = <String>[].obs;
  List<String> listPhotosSubUrls = <String>[].obs;

  var buttonTextSave = "Guardar".obs;
  var subInfoAdd = "Agregar informacion".obs;

  Rx<bool> infoMainVisible = Rx(true);
  Rx<bool> infoSubVisible = Rx(true);

  late InfoMunicipio infoMunicipioUpdate;
  int indexUpdate = 0;

  int _countTapItem = 0;
  int get countTapItem => _countTapItem;
  String tipoGestion = "";
  String uuidInfoSitio = "";

  void updateVisibilityForms(bool mainForm, bool subForm) {
    infoSubVisible.value = subForm;
    infoMainVisible.value = mainForm;
    isSaveOrUpdate.value = false;
    update();
  }

  /**
   * Actualiza la informacion del boton
   */
  void updateButtonAddSubInfo(String value, bool state) {
    subInfoAdd.value = value;
    buttonTextSave.value = "Agregar";
    isSaveOrUpdate.value = false;
    isLoading.value = true;
    update();
  }

  /**
   * Actualiza lista contenedoras de fotografias del titulo principal
   */
  void updateList(List<String> newData) {
    listPhotosUrls.assignAll(newData);
    listPhotosSubUrls.clear();
    update();
  }

  /**
   * Funcion que recibe desde la lista informacion que se va actualizar,
   * titulo pricipal o subinformacion con su respectivo index.
   */
  updateInforMunicipio(InfoMunicipio infoMunicipio, int index) {
    print("Index Actualizar: ${index}");

    if (index == -1) {
      infoMainVisible.value = true;
      infoSubVisible.value = false;
    } else {
      infoMainVisible.value = false;
      infoSubVisible.value = true;
    }

    infoMunicipioUpdate = infoMunicipio;
    indexUpdate = index;

    if (index != -1) {
      subTituloControl.text = infoMunicipio.subTitulos[index].titulo;
      subDescriptionControl.text = infoMunicipio.subTitulos[index].descripcion;
      listPhotosSubUrls = infoMunicipio.subTitulos[index].listPhotosPath!.isEmpty
          ? []
          : infoMunicipio.subTitulos[index].listPhotosPath!
          .where((element) => element is String)
          .map((element) => element.toString())
          .toList();
    } else {
      tituloControl.text = infoMunicipio.nombre;
      descriptionControl.text = infoMunicipio.descripcion;
      listPhotosUrls = infoMunicipio.photos!.isEmpty ? [] : infoMunicipio.photos!
          .where((element) => element is String)
          .map((element) => element.toString())
          .toList();
    }

    buttonTextSave.value = "Actualizar";
    subInfoAdd.value = "Actualizar informacion";
    update();
  }

  /**
   * Metodo encargado de agregar subInformacion a la lista para agregar al titulo principal
   */
  addSubinformation() {
    SubTitulo subInfoMunicipio = SubTitulo(
        titulo: subTituloControl.text,
        descripcion: subDescriptionControl.text,
        listPhotosPath: List.from(listPhotosSubInfo));

    listSubInformation.add(subInfoMunicipio);
    cleanSubInfo();
    update();
  }

  /**
   * Limpiar cajas de los subitutlos
   */
  cleanSubInfo() {
    subTituloControl.text = "";
    subDescriptionControl.text = "";
    listPhotosSubInfo.clear();
  }

  /**
   * Limpiar cajas del titulo principal.
   */
  cleanForm() {
    cleanSubInfo();
    descriptionControl.text = "";
    tituloControl.text = "";
    listPhotosInfo.clear();
    listPhotosSubInfo.clear();
    update();
  }

  /**
   * Funciones para agregar fotos que se seleccionaron. para titulo principal
   */
  addPhotosGeneral(List<CroppedFile> listPothos) {
    print("aGREGA FOTOS MAIN");
    listPhotosInfo.addAll(listPothos);
    update();
  }

  /**
   * * Funciones para agregar fotos que se seleccionaron. para subtitulos
   */
  addPhotosSub(List<CroppedFile> listPothos) {
    print("aGREGA FOTOS");
    listPhotosSubInfo.addAll(listPothos);
    update();
  }

  String uidGenerate() => _myCulturaRepository.newId();

  Future<void> saveInformation(InfoMunicipio infoMunicipio) async {
    isLoading.value = false;

    await _myCulturaRepository.saveMyGestion(infoMunicipio);
    cleanForm();
    isLoading.value = true;
    buttonTextSave.value = "Agregar";
    subInfoAdd.value = "Agregar informacion";
  }

  //Metodo que conecta con la base de datos para guardar toda la informacion
  Future<void> updateInformation(index) async {
    await _myCulturaRepository.updateInfoMain(infoMunicipioUpdate, index);
  }

  Future<void> updateSubInfomation() async {
    isLoading.value = false;

    if (listPhotosInfo.isNotEmpty) {
      infoMunicipioUpdate.photos = listPhotosInfo;
    }

    if (listPhotosSubInfo.isNotEmpty) {
      infoMunicipioUpdate.subTitulos[indexUpdate].listPhotosPath = listPhotosSubInfo;
    }

    infoMunicipioUpdate.subTitulos[indexUpdate].titulo = subTituloControl.text;
    infoMunicipioUpdate.subTitulos[indexUpdate].descripcion = subDescriptionControl.text;

    await _myCulturaRepository.editMyGestion(
        infoMunicipioUpdate, indexUpdate, listPhotosSubUrls, listPhotosUrls);
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
          uuidInfoSitio = data['id'];
          List<String> newData = (data['photos'] as List?)?.whereType<String>().toList() ?? [];
          updateList(newData);
        }
      } else {
        print("Sin datos");
        tituloControl.text = "";
        descriptionControl.text = "";
        updateList([]);
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

  void updateMunicipioInformation(int index) {
      if (validationActualization(index)) {
        updateInformation(index);
      } else {
        print("Error no hay datos para actualizar.");
        messageController.messageWarning("Actualizacion", "No hay datos para actulizar");
      }
  }

  bool validationActualization(int index) {
    bool changes = false;

    if (index == -1) {
      if (tituloControl.text != infoMunicipioUpdate.nombre ||
          descriptionControl.text != infoMunicipioUpdate.descripcion ||
          listPhotosInfo.length > 0) {
        print("Longitud inicial: " + infoMunicipioUpdate.photos!.length.toString());
        infoMunicipioUpdate.nombre = tituloControl.text;
        infoMunicipioUpdate.descripcion = descriptionControl.text;
        listPhotosInfo.forEach((dynamic element) {
          if (element is CroppedFile) {
            infoMunicipioUpdate.photos?.add(element);
          }
        });
        print("Longitud final: " + infoMunicipioUpdate.photos!.length.toString());
        changes = true;
      }
    } else {
      if (infoMunicipioUpdate.subTitulos[index].descripcion != subDescriptionControl.text ||
          infoMunicipioUpdate.subTitulos[index].titulo != subTituloControl.text ||
          listPhotosSubInfo.length > 0) {

        infoMunicipioUpdate.subTitulos[index].descripcion = subDescriptionControl.text;
        infoMunicipioUpdate.subTitulos[index].titulo = subTituloControl.text;
        listPhotosSubInfo.forEach((dynamic element) {
          if (element is CroppedFile) {
            infoMunicipioUpdate.subTitulos[index].listPhotosPath?.add(element);
          }
        });
        changes = true;
      }
    }

    return changes;
  }
}
