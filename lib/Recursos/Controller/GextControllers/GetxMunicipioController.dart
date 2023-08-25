import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetxMunicipioController extends GetxController {
  int _countTapItem = 0;

  final formKey = GlobalKey<FormState>();
  var isChecked = false.obs;

  String tipoGestion = "";
  bool _stateTextForm = true;
  bool _roleState = false;

  bool get stateTextForm => _stateTextForm;
  int get countTapItem => _countTapItem;
  bool get rolState => _roleState;

  void updateStateFormText(bool estado) {
    _stateTextForm = estado;
    update();
  }

  //Funcion para determinar la posicion del tapIndex
  void updateTapItem(int posicion) {
    _countTapItem = posicion;
    update();
  }

  void roleState(bool estado) {
    _roleState = estado;
    update();
  }
}
