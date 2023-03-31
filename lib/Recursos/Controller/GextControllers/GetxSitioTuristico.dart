import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class GetxSitioTuristico extends GetxController {
  String _id = "";
  String _nombre = "";
  String _tipoTurismo = "";
  String _capacidad = "";
  String _descripcion = "";
  String _ubicacion = "Sin ubicacion";
  String _buttonText = "Registrar";
  List<dynamic>? _fotoUrl = [];

  List<XFile> _imageFileList = [];

  String get id => _id;
  String get nombre => _nombre;
  String get tipoTurismo => _tipoTurismo;
  String get capacidad => _capacidad;
  String get descripcion => _descripcion;
  String get ubicacion => _ubicacion;
  String get buttonText => _buttonText;
  List<dynamic>? get fotoUrl => _fotoUrl;

  List<XFile> get imageFileList => _imageFileList;

  void addFilesImage(XFile image) {
    _imageFileList.add(image);
    update();
  }

  void updateSitioTuristico(String id, String nombre, String tipoTurismo,
      String capacidad, String descripcion, String ubicacion, List<dynamic>? fotos) {
    print("Llega informacion" + id +  "foto estado: " + fotos.toString());
    _id = id;
    _nombre = nombre;
    _tipoTurismo = tipoTurismo;
    _capacidad = capacidad;
    _descripcion = descripcion;
    _ubicacion = ubicacion;
    _fotoUrl = fotos;
    _buttonText = "Actualizar";
    update();
  }

  void updateUbicacion(String ubicacion) {
    _ubicacion = ubicacion;
    update();
  }

  void cleanTurismo() {
    _id = "";
    _nombre = "";
    _tipoTurismo = "Seleccionar";
    _capacidad = "";
    _descripcion = "";
    _ubicacion = "";
    _buttonText = "Registrar";
    update();
  }
}
