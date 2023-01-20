import 'package:get/get.dart';

class GextControllerTurismo extends GetxController {

  int _countTapItem = 0;

  String _tipoGestion = "";
  bool  _stateTextForm = true;

  String get typeInformation => _tipoGestion;
  bool get stateTextForm => _stateTextForm;
  int get countTapItem => _countTapItem;

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

}
