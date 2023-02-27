
import 'package:app_turismo/Recursos/Controller/GestionController.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GetxGestionInformacion.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GexTurismo.dart';
import 'package:app_turismo/Recursos/Models/GestionModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:app_turismo/Recursos/Constants/Constans.dart';

class ModuleGestion extends StatefulWidget {
  const ModuleGestion({Key? key}) : super(key: key);

  @override
  State<ModuleGestion> createState() => _ModuleGestionState();
}

class _ModuleGestionState extends State<ModuleGestion> {

  final GetxGestionInformacionController controllerGestion =
  Get.put(GetxGestionInformacionController());

  final GextControllerTurismo controllerTurismo =
  Get.put(GextControllerTurismo());

  final gestionModel = Get.arguments as GestionModel?;

  final _nombreInformacion = TextEditingController();
  final _posicionInformacion = TextEditingController();
  final _descripcionInformacion = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String idGestion = "";
  Position? _position;
  String _ubicacionC = "";



  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: FormGestion(),
          )),
    );
  }

  //Fomulario
  Widget FormGestion() {
    final editController = Get.put(EditGestionController());
    final editControlGestion = Get.find<GetxGestionInformacionController>();

    List<XFile>? images = [];
    List<dynamic>? fotografias = [];

    PickedFile? _pickedFile = null;

    idGestion = controllerGestion.id;
    _nombreInformacion.text = controllerGestion.nombre;
    _ubicacionC = controllerGestion.ubicacion;
    _descripcionInformacion.text = controllerGestion.descripcion;
    fotografias = controllerGestion.fotoUrl;

    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Nombre"),
            TextFieldWidget(
                _nombreInformacion,
                Icon(Icons.abc, color: Colors.green),
                "Nombre de la " + controllerTurismo.typeInformation,
                1,
                "Error, falta nombre",
                TextInputType.text),
            SizedBox(height: 20),
            Text("Descripcion"),
            TextFieldWidget(
                _descripcionInformacion,
                Icon(Icons.description, color: Colors.green),
                "Descripcion de la " + controllerTurismo.typeInformation,
                3,
                "Error, complete la descripcion",
                TextInputType.text),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
                    Text("Fotografias"),
                    ElevatedButton(
                        style: Constants.buttonPrimary,
                        onPressed: () async {

                          final editController = Get.find<EditGestionController>();
                          final editControlInformacion = Get.find<GetxGestionInformacionController>();
                          images = await _picker.pickMultiImage();

                          final List<XFile>? selectedImages = await
                          _picker.pickMultiImage();
                          if (selectedImages!.isNotEmpty) {
                            images!.addAll(selectedImages);
                            editControlInformacion.updateFilesImage(
                                selectedImages);

                            print("Foto seleccionada.");
                            Get.showSnackbar(GetSnackBar(
                              title: 'Fotografia',
                              message: "Se cargaron: "
                                  + selectedImages!.length.toString()
                                  + " fotografias",
                              icon: Icon(Icons.app_registration),
                              duration: Duration(seconds: 6),
                              backgroundColor: Colors.green.shade400,
                            ));
                          }
                        },
                        child: const Text('Cargar fotos'))
                  ],
                ),
                Column(
                  children: [
                    Text("Ubicacion Gps"),
                    ElevatedButton(
                        style: Constants.buttonPrimary,
                        onPressed: () {
                          _getCurrentLocation();
                        },
                        child: const Text('Seleccionar Ubicacion'))
                  ],
                )
              ],
            ),
            SizedBox(height: 35),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                  style: Constants.buttonPrimary,
                  onPressed: () {
                    String mensaje = "";
                    String errorMensaje = images == null
                        ? 'Error falta Fotografia'
                        : 'Error falta Ubicacion';

                    if (_formKey.currentState!.validate()) {
                      if (_ubicacionC.isEmpty) {
                        Get.showSnackbar(GetSnackBar(
                          title: 'Validacion de datos',
                          message: errorMensaje,
                          icon: Icon(Icons.app_registration),
                          duration: Duration(seconds: 5),
                          backgroundColor: Colors.red,
                        ));
                      } else {
                        if (idGestion.isEmpty) {
                          mensaje = "Se guardaron los datos";
                          editController.saveGestion(
                              _nombreInformacion.text,
                              _descripcionInformacion.text,
                              _ubicacionC.toString());

                        } else {
                          mensaje = "Se actualizaron los datos";
                          editController.editGestion(
                            idGestion, _nombreInformacion.text,
                              _descripcionInformacion.text,
                              _ubicacionC.toString(),
                              fotografias
                          );
                        }
                        cleanForm();
                        Get.showSnackbar(GetSnackBar(
                          title: 'Registro de informacion',
                          message: mensaje,
                          icon: Icon(Icons.app_registration),
                          duration: Duration(seconds: 4),
                          backgroundColor: Colors.green.shade400,
                        ));
                      }
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 12.0),
                    child: const Text(
                      'Guardar',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ))
            ]),
          ],
        ));
  }

//Funciones para localizacion
  void _getCurrentLocation() async {
    Position position = await _determinePosition();
    final GetxGestionInformacionController _controllerInformacion =
    Get.put(GetxGestionInformacionController());
    _controllerInformacion.updateUbicacion(position.toString());

    print("Posicionado: " + position.toString());
    Get.showSnackbar(GetSnackBar(
      title: 'Ubicacion',
      message: "Ubicacion capturada: "
          + position.toString(),
      icon: Icon(Icons.app_registration),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.green,
    ));

    _ubicacionC = position.toString();
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  Widget TextFieldWidget(
      TextEditingController controlador,
      icon,
      String textGuide,
      int maxLine,
      String msgError,
      TextInputType textInputType) {
    return TextFormField(
        controller: controlador,
        keyboardType: textInputType,
        maxLines: maxLine,
        decoration: InputDecoration(
          prefixIcon: icon,
          fillColor: Colors.grey.shade300,
          filled: true,
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.green)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          hintText: textGuide,
          labelStyle: TextStyle(color: Colors.green),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return msgError;
          }
        },
        cursorColor: Colors.green);
  }

  void cleanForm() {
    _descripcionInformacion.clear();
    _nombreInformacion.clear();
    _posicionInformacion.clear();
    _ubicacionC = "";


  }
}
