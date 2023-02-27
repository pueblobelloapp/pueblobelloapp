import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class GetxGestionInformacionController extends GetxController {
  String _id = "";
  String _nombre = "";
  String _descripcion = "";
  String _ubicacion = "";
  String _buttonText = "Agregar";



  List<dynamic>? _fotoUrl = [];

  String get id => _id;
  String get nombre => _nombre;
  String get descripcion => _descripcion;
  String get ubicacion => _ubicacion;
  String get buttonText => _buttonText;

  List<dynamic>? get fotoUrl => _fotoUrl;
  List<XFile> _imageFileList = [];
  List<XFile> get imageFileList => _imageFileList;

  void updateFilesImage(List<XFile> imageFileList) {
    _imageFileList = imageFileList;
    update();
  }

  void updateUbicacion(String ubicacion) {
    _ubicacion = ubicacion;
    update();
  }

  void updateGestionInformacion(String id, String nombre, String descripcion,
      List<dynamic>? fotos, String ubicacion, String buttonTex) {

    _nombre = nombre;
    _descripcion = descripcion;
    _fotoUrl = fotos;
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
