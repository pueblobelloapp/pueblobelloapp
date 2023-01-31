import 'package:get/get.dart';

class GextControllerTurismo extends GetxController {

  int _countTapItem = 0;

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

}
