import 'dart:io';

import 'package:app_turismo/Recursos/Models/SiteTuristico.dart';
import 'package:app_turismo/Recursos/Repository/RepositorySiteTuristico.dart';
import 'package:app_turismo/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../Models/InfoMunicipio.dart';
import 'GextUtils.dart';

class GetxSitioTuristico extends GetxController {
  final MySitesRepository _mySitesRepository = getIt();
  final GetxUtils messageController = Get.put(GetxUtils());
  final formKey = GlobalKey<FormState>();

  List<XFile> listPickedFile = [];
  List<CroppedFile> listCroppedFile = [];

  String _buttonText = "Registrar";
  List<dynamic>? _fotoUrl = [];

  var ubicacion = 'Sin ubicacion'.obs;

  String get buttonText => _buttonText;
  List<dynamic>? get fotoUrl => _fotoUrl;

  String _menuItemsActivity = "";
  late LatLng selectedLatLng = LatLng(10.422522, -73.578462);

  final nombreSitio = TextEditingController();
  final tipoTurismo = TextEditingController();
  final descripcionST = TextEditingController();

  final facebookTextController = TextEditingController();
  final twitterTextController = TextEditingController();
  final messengerTextController = TextEditingController();
  final instagramTextController = TextEditingController();
  final whatsappTextController = TextEditingController();

  Map<String, String> _listContactos = {};
  late Ubicacion mapUbications;

  String uidUserLogin = "";

  void updateUidUserLogin(uidUser) {
    uidUserLogin = uidUser;
    update();
  }

  bool determineAspectRatio(CroppedFile photos) {
    double aspectRatio = 0;
    bool aspectBool = false;

    Image image = Image.file(File(photos.path));
    image.image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          var myImage = image.image;
          aspectRatio = myImage.width.toDouble() / myImage.height.toDouble();
        },
      ),
    );

    if (aspectRatio == 1 || aspectRatio == 3 / 2 || aspectRatio == 4 / 3 || aspectRatio == 16 / 9) {
      aspectBool = true;
    }

    return aspectBool;
  }

  void updatePosition(LatLng latLng) {
    print("Actualizando ubicacion");
    selectedLatLng = latLng;
    ubicacion.value = "Ubicacion seleccionada \n ${latLng.latitude.toString()}";
    mapUbications = Ubicacion(
        lat: latLng.latitude.toString(),
        long:  latLng.longitude.toString());

    update();
  }

  void updateActivity(List<dynamic> activitys) {
    print(activitys);
    _menuItemsActivity = "";
    activitys.forEach((e) => _menuItemsActivity += '#${(e.toString())} ');
    update();
  }

  void updateContactos() {
    _listContactos = {
      "facebook": facebookTextController.text,
      "twitter": twitterTextController.text,
      "messenger": messengerTextController.text,
      "instagram": instagramTextController.text,
      "whatsapp": whatsappTextController.text
    };
    update();
  }

  void cleanTurismo() {
    _buttonText = "Registrar";
    update();
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Sitio de interes"), value: "sitio_interes"),
      DropdownMenuItem(child: Text("Sitio turistico"), value: "sitio_turistico"),
      DropdownMenuItem(child: Text("Bienestar"), value: "bienestar"),
      DropdownMenuItem(child: Text("Ecoturismo"), value: "ecoturismo"),
      DropdownMenuItem(child: Text("Rural"), value: "rural")
    ];
    return menuItems;
  }

  Stream<QuerySnapshot> dropdownActivity() {
    Stream<QuerySnapshot> menuItems = _mySitesRepository.getAvtivity();
    return menuItems;
  }

  Future<void> validateForms() async {
    if (validateText()) {
      print("Realizando proceso de guardado.");

      SitioTuristico sitioTuristico = SitioTuristico(
          id: _mySitesRepository.newId(),
          nombre: nombreSitio.text,
          tipoTurismo: tipoTurismo.text,
          descripcion: descripcionST.text,
          ubicacion: mapUbications,
          contacto: _listContactos,
          actividades: _menuItemsActivity,
          puntuacion: []);

      _mySitesRepository.saveMySite(sitioTuristico);
      cleanForm();
    } else {
      print("Error campos vacios");
      Get.showSnackbar(const GetSnackBar(
        title: 'Validacion de datos',
        message: 'Error datos faltantes',
        icon: Icon(Icons.app_registration),
        duration: Duration(seconds: 4),
        backgroundColor: Colors.red,
      ));
    }
  }

  void cleanForm() {
    nombreSitio.text = "";
    tipoTurismo.text = "";
    descripcionST.text = "";
    twitterTextController.text = "";
    facebookTextController.text = "";
    messengerTextController.text = "";
    instagramTextController.text = "";
    whatsappTextController.text = "";
    ubicacion.value = "Sin ubicacion";
    _listContactos.clear();
  }

  bool validateText() {
    updateContactos();

    return (nombreSitio.text.isNotEmpty &&
        descripcionST.text.isNotEmpty &&
        tipoTurismo.text.isNotEmpty &&
        _menuItemsActivity.isNotEmpty &&
        ubicacion.value.isNotEmpty);
  }
}
