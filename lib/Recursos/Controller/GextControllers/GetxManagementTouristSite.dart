import 'dart:io';

import 'package:app_turismo/Recursos/Models/SiteTuristico.dart';
import 'package:app_turismo/Recursos/Repository/RepositorySiteTuristico.dart';
import 'package:app_turismo/Recursos/Repository/implementation/RepositorySiteTuristicoImp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../Models/InfoMunicipio.dart';
import 'GextUtils.dart';

class GetxManagementTouristSite extends GetxController {
  final MySitesRepository _mySitesRepository = MyRepositorySiteTuristicoImp();
  final GetxUtils messageController = Get.put(GetxUtils());
  final keySiteTuris = GlobalKey<FormState>();

  List<XFile> listPickedFile = [];
  List<CroppedFile> listCroppedFile = [];

  String _buttonText = "Registrar";
  List<dynamic>? _fotoUrl = [];
  List<String> listActivitys = [];

  var ubicacion = 'Sin ubicacion'.obs;

  String get buttonText => _buttonText;
  List<dynamic>? get fotoUrl => _fotoUrl;

  String _menuItemsActivity = "";
  late LatLng selectedLatLng = LatLng(0, 0);

  final nombreSitio = TextEditingController();
  final tipoTurismo = TextEditingController();
  final descripcionST = TextEditingController();

  final facebookTextController = TextEditingController();
  final twitterTextController = TextEditingController();
  final pageWebTextController = TextEditingController();
  final instagramTextController = TextEditingController();
  final whatsappTextController = TextEditingController();

  var titleAppbar = "Registro Sitio Turistico".obs;
  var buttonTextSave = "Guardar".obs;

  late SitioTuristico siteInformation;

  Rx<bool> infoExists = Rx(true);

  Map<String, String> _listContactos = {};
  late Ubicacion mapUbications = Ubicacion(lat: "0", long: "0");

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
    selectedLatLng = latLng;
    if (latLng.longitude != 0 && latLng.latitude != 0) {
      ubicacion.value = "Ubicacion seleccionada \n ${latLng.latitude.toString()}";
    }
    mapUbications = Ubicacion(lat: latLng.latitude.toString(), long: latLng.longitude.toString());

    update();
  }

  void updateActivity(List<dynamic> activitys) {
    _menuItemsActivity = "";
    activitys.forEach((e) => _menuItemsActivity += '#${(e.toString())} ');
    update();
  }

  void updateContactos() {
    _listContactos = {
      "facebook": facebookTextController.text,
      "twitter": twitterTextController.text,
      "pagina": pageWebTextController.text,
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
      updateContactos();
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
    pageWebTextController.text = "";
    instagramTextController.text = "";
    whatsappTextController.text = "";
    ubicacion.value = "Sin ubicacion";
    _listContactos.clear();
  }

  bool validateText() {
    return (nombreSitio.text.isNotEmpty &&
        descripcionST.text.isNotEmpty &&
        tipoTurismo.text.isNotEmpty &&
        _menuItemsActivity.isNotEmpty &&
        ubicacion.value.isNotEmpty);
  }

  setDataToForm() {
    print("Llamado");
    nombreSitio.text = siteInformation.nombre;
    tipoTurismo.text = siteInformation.tipoTurismo;
    descripcionST.text = siteInformation.descripcion;
    tipoTurismo.text = siteInformation.tipoTurismo;
    ubicacion.value = "Ubicacion seleccionada \n ${siteInformation.ubicacion!.lat}";
    setActivitySelect(siteInformation.actividades);
    setDataRedes();
  }
  setActivitySelect(String? input) {
    listActivitys.clear();
    print("Actividades");
    RegExp regExp = RegExp(r'#(\w+)');
    Iterable<RegExpMatch> matches = regExp.allMatches(input!);

    for (RegExpMatch match in matches) {
      String hashtag = match.group(1)!; //hashtag = hashtag.replaceAll('_', ' ');
      listActivitys.add(hashtag);
    }
  }

  setDataRedes() {
    twitterTextController.text = siteInformation.contacto!['twitter'];
    facebookTextController.text = siteInformation.contacto!['facebook'];
    pageWebTextController.text = siteInformation.contacto!['pagina'];
    instagramTextController.text = siteInformation.contacto!['instagram'];
    whatsappTextController.text = siteInformation.contacto!['whatsapp'];
  }
}
