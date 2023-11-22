import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class GextPropietarioController extends GetxController {
  int _countTapItem = 0;
  String _id = "";
  String _nombre = "";
  String _sitioTuristico = "";
  String _edad = "";
  String _correo = "";
  String _clave = "La clave";
  String _foto = "";
  String _contacto = "";
  String _genero = "";
  String _buttonText = "Registrar";
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
  int get countTapItem => _countTapItem;
  String get dropdownValue => _dropdownValue;

  void updateTapItem(int posicion) {
    _countTapItem = posicion;
    update();
  }

  void updatePropietario(Map<String, dynamic> propietario, String button) {
    _id = propietario["uid"];
    _nombre = propietario["nombre"];
    _edad = propietario["edad"];
    _correo = propietario["correo"];
    _foto = propietario["foto"];
    _contacto = propietario["contacto"];
    _dropdownValue = propietario["genero"];
    _buttonText = button;
    update();
  }

  var imagePerfil = XFile('').obs;
  var imagePerfilUrl = ''.obs;

  void updateImagePerfil(XFile imageFile) async {
    imagePerfil.value = imageFile;
    update();
  }

  void updateButtonText(String button) {
    _buttonText = button;
    update();
  }

  void updateGenero(String genero) {
    _dropdownValue = genero;
    update();
  }

  void cleanPropietario() {
    _id = "";
    _nombre = "";
    _sitioTuristico = "";
    _edad = "";
    _correo = "";
    _clave = "";
    _foto = "";
    _contacto = "";
    _dropdownValue = "";
    _buttonText = "Registrar";
    update();
  }
}
