import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class GextControllerTurismo extends GetxController {

  int _countTapItem = 0;

  Position? _position;
  final nombreST = TextEditingController();
  final tipoTurismo = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final capacidadST = TextEditingController();
  final descripcionST = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String ubicacionST = "";
  var isChecked = false.obs;

  String _tipoGestion = "";
  bool  _stateTextForm = true;
  bool _roleState = false;
  String _uidUserLogin = "";

  String get typeInformation => _tipoGestion;
  bool get stateTextForm => _stateTextForm;
  int get countTapItem => _countTapItem;
  bool get rolState => _roleState;
  String get uidUser => _uidUserLogin;

  void updateUidUserLogin( uidUser ) {
    _uidUserLogin = uidUser;
    update();
  }

  void updateStateFormText(bool estado) {
    _stateTextForm = estado;
    update();
  }

  //Funcion para determinar la posicion del tapIndex
  void updateTapItem(int posicion) {
    _countTapItem = posicion;
    update();
  }

  void tipoGestion(String tipoGestion) {
    _tipoGestion = tipoGestion;
    update();
  }

  void roleState(bool estado) {
    _roleState = estado;
    update();
  }

  Future<void> validateForms() async {
    if (formKey.currentState!.validate()) {
      print("Error campos vacios");
      Get.showSnackbar(const GetSnackBar(
        title: 'Validacion de datos',
        message: 'Error datos faltantes',
        icon: Icon(Icons.app_registration),
        duration: Duration(seconds: 4),
        backgroundColor: Colors.red,
      ));
    } else {
      print("Turismo registrado con : " + uidUser);
    }
  }

}
