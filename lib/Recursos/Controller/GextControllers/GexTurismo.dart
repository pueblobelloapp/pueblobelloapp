import 'package:get/get.dart';

class GextControllerTurismo extends GetxController {

  int _countTapItem = 0;

  String _tipoGestion = "";

  String get typeInformation => _tipoGestion;

  int get countTapItem => _countTapItem;


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
