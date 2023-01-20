import 'package:get/get.dart';

class GetxGestionInformacionController extends GetxController {
  String _id = "";
  String _nombre = "";
  String _descripcion = "";
  String _foto = "";
  String _ubicacion = "";
  String _buttonText = "Agregar";

  String get id => _id;
  String get nombre => _nombre;
  String get descripcion => _descripcion;
  String get foto => _foto;
  String get ubicacion => _ubicacion;
  String get buttonText => _buttonText;

  void updateGestionInformacion(String id, String nombre, String descripcion,
      String foto, String ubicacion, String buttonTex) {

    _nombre = nombre;
    _descripcion = descripcion;
    _foto = foto;
    _id = id;
    _ubicacion = ubicacion;
    _buttonText = buttonTex;
    update();
  }

  void updateButtonText(String button) {
    _buttonText = button;
    update();
  }
}
