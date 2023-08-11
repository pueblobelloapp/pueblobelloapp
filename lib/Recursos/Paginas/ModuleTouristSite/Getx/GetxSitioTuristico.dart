import 'package:app_turismo/Recursos/Paginas/ModuleTouristSite/Controller/SitesController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class GetxSitioTuristico extends GetxController {
  final EditSitesController editSitesController =
      Get.put(EditSitesController());
  final formKey = GlobalKey<FormState>();

  String _ubicacion = "Sin ubicacion";
  String _buttonText = "Registrar";
  List<dynamic>? _fotoUrl = [];

  String get ubicacion => _ubicacion;
  String get buttonText => _buttonText;
  List<dynamic>? get fotoUrl => _fotoUrl;

  List<XFile> _imageFileList = [];
  List<XFile> get imageFileList => _imageFileList;

  List<DropdownMenuItem<String>> _menuItemsActivity = [];
  List<DropdownMenuItem<String>> get menuItemsActivity => _menuItemsActivity;

  final nombreSitio = TextEditingController();
  final tipoTurismo = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final capacidadST = TextEditingController();
  final descripcionST = TextEditingController();
  String ubicacionST = "";

  final facebookTextController = TextEditingController();
  final twitterTextController = TextEditingController();
  final messengerTextController = TextEditingController();
  final instagramTextController = TextEditingController();
  final whatsappTextController = TextEditingController();

  late Map<String, String> _listContactos;
  Map<String, String> get listContactos => _listContactos;

  void uodateActivity(List<DropdownMenuItem<String>> value) {
    print("Actualizando lista");
    _menuItemsActivity = value;
    update();
  }

  void updateContactos() {
    _listContactos['facebook'] = facebookTextController.text;
    _listContactos['twitter'] = twitterTextController.text;
    _listContactos['messenger'] = messengerTextController.text;
    _listContactos['instagram'] = instagramTextController.text;
    _listContactos['whatsapp'] = whatsappTextController.text;
    update();
  }

  void addFilesImage(XFile image) {
    _imageFileList.add(image);
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

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Sitio de interes"), value: "sitio_interes"),
      DropdownMenuItem(
          child: Text("Sitio turistico"), value: "sitio_turistico"),
      DropdownMenuItem(child: Text("Bienestar"), value: "bienestar"),
      DropdownMenuItem(child: Text("Ecoturismo"), value: "ecoturismo"),
      DropdownMenuItem(child: Text("Rural"), value: "rural"),
    ];
    return menuItems;
  }

  Future<void> get dropdownActivity async {
    print("inicio");
    List<DropdownMenuItem<String>> menuItems = await
        editSitesController.getAvtivity();

    uodateActivity(menuItems);
  }

  Future<void> validateForms() async {
    print(facebookTextController.text);
    print(twitterTextController.text);
    print(whatsappTextController.text);

    if (formKey.currentState!.validate()) {
      print("Error campos vacios");
      Get.showSnackbar(const GetSnackBar(
        title: 'Validacion de datos',
        message: 'Error datos faltantes',
        icon: Icon(Icons.app_registration),
        duration: Duration(seconds: 4),
        backgroundColor: Colors.red,
      ));
    } else {
      print("Realizando proceso de guardado.");

      /*SitioTuristico sitioTuristico = SitioTuristico(
          id: "",
          nombre: nombreSitio.text,
          tipoTurismo: tipoTurismo.text,
          descripcion: descripcionST.text,
          ubicacion: ubicacion,
          contacto: _listContactos,
          actividades: null,
          userId: "");*/

      //editSitesController.saveSite(sitioTuristico);
    }
  }

  Widget textFormSocialRed(TextEditingController controllerEdit) {
    return TextFormField(
        controller: controllerEdit, keyboardType: TextInputType.text);
  }
}
