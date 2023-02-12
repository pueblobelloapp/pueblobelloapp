import 'package:get/get.dart';

class GextPropietarioController extends GetxController {
  String _id = "";
  String _nombre = "";
  String _sitioTuristico = "";
  String _edad = "";
  String _correo = "";
  String _clave = "La clave";
  String _foto = "";
  String _contacto = "";
  String _genero = "";
  String _buttonText = "";
  String _dropdownValue = "";

  List<String> list = <String>['Masculino', 'Femenino'];


  String get id => _id;
  String get nombre => _nombre;
  String get sitioTuristico => _sitioTuristico;
  String get edad => _edad;
  String get correo => _correo;
  String get clave => _clave;
  String get foto => _foto;
  String get contacto => _contacto;
  String get genero => _genero;
  String get buttonText => _buttonText;

  String get dropdownValue => _dropdownValue;

  void updatePropietario(
      String id,
      String nombre,
      String sitioTuristico,
      String edad,
      String correo,
      String clave,
      String foto,
      String contacto,
      String genero,
      String buttonText) {

    print("Llega informacion" + id);
    _id = id;
    _nombre = nombre;
    _sitioTuristico = sitioTuristico;
    _edad = edad;
    _correo = correo;
    _clave = clave;
    _foto = foto;
    _contacto = contacto;
    _dropdownValue = genero;
    _buttonText = buttonText;
    update();

  }

  void updateButtonText(String button) {
    _buttonText = button;
    update();
  }

  void updateGenero(String genero ) {
    _dropdownValue = genero;
    update();
  }
}
