import 'dart:async';
import 'package:app_turismo/Recursos/Controller/GextControllers/GetxConnectivity.dart';
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
  final ConnectivityController connectivityController = Get.put(ConnectivityController());

  late Stream<QuerySnapshot> informationStream;

  final keyTitleMain = GlobalKey<FormState>();
  final keyTitleSub = GlobalKey<FormState>();

  final tituloControl = TextEditingController();
  final descriptionControl = TextEditingController();
  final subTituloControl = TextEditingController();
  final subDescriptionControl = TextEditingController();

  Rx<bool> isSaveInformation = Rx(true);
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
    update();
  }

  /**
   * Actualiza la informacion del boton
   */
  void updateButtonAddSubInfo(String value, bool state) {
    subInfoAdd.value = value;
    buttonTextSave.value = "Agregar";
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
   * Muestra informacion en los formularios, para actualizar igual las fotografias
   * ya existentes en la base de datos de firebase.
   */
  updateInforMunicipio(InfoMunicipio infoMunicipio, int index) {
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
      listPhotosUrls = infoMunicipio.photos!.isEmpty
          ? []
          : infoMunicipio.photos!
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
    SubTitulo subInfoMunicipio = getValuesSubTitle();
    listSubInformation.add(subInfoMunicipio);
    cleanForm();
    update();
  }

  /**
   * Limpia forms.
   */
  cleanForm() {
    descriptionControl.text = "";
    tituloControl.text = "";
    listPhotosInfo.clear();
    subTituloControl.text = "";
    subDescriptionControl.text = "";
    listPhotosSubInfo.clear();
    update();
  }

  /**
   * Funciones para agregar fotos que se seleccionaron. para titulo principal
   */
  addPhotosGeneral(List<CroppedFile> listPothos) {
    listPhotosInfo.addAll(listPothos);
    update();
  }

  /**
   * * Funciones para agregar fotos que se seleccionaron. para subtitulos
   */
  addPhotosSub(List<CroppedFile> listPothos) {
    listPhotosSubInfo.addAll(listPothos);
    update();
  }

  String uidGenerate() => _myCulturaRepository.newId();

  Future<void> saveInformation(InfoMunicipio infoMunicipio) async {
    await _myCulturaRepository.saveMyGestion(infoMunicipio);
    cleanForm();
    buttonTextSave.value = "Agregar";
    subInfoAdd.value = "Agregar informacion";
  }

  Future<void> updateInformation(index) async {
    buttonTextSave.value = "Actualizando";

    await _myCulturaRepository
        .updateInfoMain(infoMunicipioUpdate, index)
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

  Future<void> updateSubInfomation() async {
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
  }

  Stream<QuerySnapshot> listInfo() {
    final Stream<QuerySnapshot> _informationStream = FirebaseFirestore.instance
        .collection('dataTurismo')
        .where('subCategoria', isEqualTo: tipoGestion)
        .snapshots();

    this.informationStream = _informationStream;
    informationStream.listen((QuerySnapshot snapshot) {
      if (snapshot.docs.isEmpty) {
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

  void updateTapItem(int posicion) {
    _countTapItem = posicion;
    update();
  }

  void updateMunicipioInformation(int index) async {
    if (connectivityController.isOnline.value) {
      if (validationActualization(index)) {
        await updateInformation(index).then((value) {
          Get.back();
          cleanForm();
        });
      } else {
        print("Error no hay datos para actualizar.");
        messageController.messageWarning("Actualizacion", "No hay datos para actulizar");
      }
    } else {
      messageController.messageError("Conexion", "Verifica tu conexion a internet.");
    }
  }

  bool validationActualization(int index) {
    bool changes = false;
    if (index == -1) {
      if (tituloControl.text != infoMunicipioUpdate.nombre ||
          descriptionControl.text != infoMunicipioUpdate.descripcion ||
          listPhotosInfo.length > 0) {
        infoMunicipioUpdate.nombre = tituloControl.text;
        infoMunicipioUpdate.descripcion = descriptionControl.text;
        listPhotosInfo.forEach((dynamic element) {
          if (element is CroppedFile) {
            infoMunicipioUpdate.photos?.add(element);
          }
        });
        listPhotosUrls = [];
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

  Future<bool> updateActionButton() async {
    InfoMunicipio information = getValuesMunicipio();
    SubTitulo subTitulo = getValuesSubTitle();

    //MEJORAR LOGICA CON LA VARIAVLE ISSAVEINFORMATION
    if (infoSubVisible.value == true && infoMainVisible == false && isSaveInformation.isTrue) {
      print("Agregando infformacion");
      print("Valor: " + infoMunicipioUpdate.toFirebaseMap().toString());
     /* addInformation(infoMunicipioUpdate, subTitulo).then((value) {
        cleanForm();
      });*/
    } else {
      //Si es verdadero, existe una peticion al servidor todavia ejecutandoce.
        if (isSaveInformation.isTrue) {
          updateMunicipioInformation(indexUpdate);
        } else {
          information.id = uidGenerate();
          saveInformation(information);
        }
      cleanForm();
    }
    return true;
  }

  /**
   * Metodo encargado de agregar subtitulos a los datos existentes.
   * @param infoMunicipio Datos traidos de la base de datos.
   */
  Future<void> addInformation(InfoMunicipio infoMunicipio, SubTitulo subTitulo) async {
    infoMunicipio.subTitulos.add(subTitulo);

    await _myCulturaRepository.saveMyGestion(infoMunicipio).then((value) {
      messageController.messageInfo("Informacion", "Se agrego correctamente.");
    });
  }

  InfoMunicipio getValuesMunicipio() {
    InfoMunicipio information = InfoMunicipio(
        nombre: tituloControl.text,
        descripcion: descriptionControl.text,
        subTitulos: listSubInformation,
        photos: listPhotosInfo,
        subCategoria: tipoGestion.toString());
    return information;
  }

  SubTitulo getValuesSubTitle() {
    SubTitulo subTitulo = SubTitulo(
        descripcion: subDescriptionControl.text,
        titulo: subTituloControl.text,
        listPhotosPath: List.from(listPhotosSubInfo));
    return subTitulo;
  }
}
