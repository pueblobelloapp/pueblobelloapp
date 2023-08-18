import 'package:app_turismo/Recursos/Models/SiteTuristico.dart';
import 'package:app_turismo/Recursos/Repository/RepositorySiteTuristico.dart';
import 'package:app_turismo/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetxSitioTuristico extends GetxController {
  final MySitesRepository _mySitesRepository = getIt();
  final formKey = GlobalKey<FormState>();
  
  String _buttonText = "Registrar";
  List<dynamic>? _fotoUrl = [];

  var ubicacion = 'Sin ubicacion'.obs;

  String get buttonText => _buttonText;
  List<dynamic>? get fotoUrl => _fotoUrl;

  List<dynamic> _menuItemsActivity = [];
  List<dynamic> get menuItemsActivity => _menuItemsActivity;

  final nombreSitio = TextEditingController();
  final tipoTurismo = TextEditingController();
  final descripcionST = TextEditingController();

  final facebookTextController = TextEditingController();
  final twitterTextController = TextEditingController();
  final messengerTextController = TextEditingController();
  final instagramTextController = TextEditingController();
  final whatsappTextController = TextEditingController();

  late Map<String, String> _listContactos;
  Map<String, String> get listContactos => _listContactos;

  void updateActivity(List<dynamic> activitys) {
    activitys.map((e) => _menuItemsActivity.add(e.toString()));
    update();
  }

  void updateContactos() {
    _listContactos['facebook'] = facebookTextController.text;
    _listContactos['twitter'] = twitterTextController.text;
    _listContactos['messenger'] = messengerTextController.text;
    _listContactos['instagram'] = instagramTextController.text;
    _listContactos['whatsapp'] = whatsappTextController.text;
    update();
  }


  void cleanTurismo() {
    _buttonText = "Registrar";
    update();
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Sitio de interes"), value: "sitio_interes"),
      DropdownMenuItem(
          child: Text("Sitio turistico"), value: "sitio_turistico"),
      DropdownMenuItem(child: Text("Bienestar"), value: "bienestar"),
      DropdownMenuItem(child: Text("Ecoturismo"), value: "ecoturismo"),
      DropdownMenuItem(child: Text("Rural"), value: "rural"),
    ];
    return menuItems;
  }

  Stream<QuerySnapshot> dropdownActivity() {
    Stream<QuerySnapshot> menuItems = _mySitesRepository.getAvtivity();
    return menuItems;
  }

  Future<void> validateForms() async {
    /* print(nombreSitio.text);
    print(descripcionST.text);
    print(tipoTurismo.text);
    print(_menuItemsActivity);
    print(twitterTextController.text);
    print(messengerTextController.text);
    print(instagramTextController.text);
    print(whatsappTextController.text);
    print(facebookTextController.text); */

    if (validateText()) {
      print("Error campos vacios");
      Get.showSnackbar(const GetSnackBar(
        title: 'Validacion de datos',
        message: 'Error datos faltantes',
        icon: Icon(Icons.app_registration),
        duration: Duration(seconds: 4),
        backgroundColor: Colors.red,
      ));
    } else {
      print("Realizando proceso de guardado.");

      SitioTuristico sitioTuristico = SitioTuristico(
          id: _mySitesRepository.newId(),
          nombre: nombreSitio.text,
          tipoTurismo: tipoTurismo.text,
          descripcion: descripcionST.text,
          ubicacion: ubicacion.value,
          contacto: _listContactos,
          actividades: _menuItemsActivity,
          userId: "");


      print("Guardando: " + sitioTuristico.toString());
      //_mySitesRepository.saveMySite(sitioTuristico);
    }
  }

  Widget textFormSocialRed(TextEditingController controllerEdit) {
    return TextFormField(
        controller: controllerEdit, keyboardType: TextInputType.text);
  }

  bool validateText() {
    if (nombreSitio.text.isNotEmpty &&
    descripcionST.text.isNotEmpty &&
    tipoTurismo.text.isNotEmpty &&
    _menuItemsActivity.isNotEmpty &&
    ubicacion.isNotEmpty) {
      updateContactos();
      return true;
    } else {
      return false;
    }
  }
}
