import 'package:app_turismo/Recursos/Models/SiteTuristico.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class GetxSitioTuristico extends GetxController {
  var _sitioTuristico = new SitioTuristico(
      id: "",
      nombre: "",
      estado: true,
      tipoTurismo: "",
      descripcion: "",
      ubicacion: "",
      userId: "");

  String _ubicacion = "Sin ubicacion";
  String _buttonText = "Registrar";
  List<dynamic>? _fotoUrl = [];

  List<XFile> _imageFileList = [];

  SitioTuristico get sitioTuristico => _sitioTuristico;
  String get ubicacion => _ubicacion;
  String get buttonText => _buttonText;
  List<dynamic>? get fotoUrl => _fotoUrl;

  List<XFile> get imageFileList => _imageFileList;

  void addFilesImage(XFile image) {
    _imageFileList.add(image);
    update();
  }

  void updateSitioTuristico(SitioTuristico sitioTuristico) {
    _sitioTuristico = sitioTuristico;
    _buttonText = "Actualizar";
    update();
  }

  void updateUbicacion(String ubicacion) {
    _ubicacion = ubicacion;
    update();
  }

  void cleanTurismo() {
    _ubicacion = "";
    _buttonText = "Registrar";
    update();
  }
}
