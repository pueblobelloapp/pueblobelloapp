// ignore_for_file: unused_local_variable, unused_import, deprecated_member_use

import 'dart:io';
import 'package:app_turismo/Recursos/Controller/GestionController.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GetxGestionInformacion.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GexTurismo.dart';
import 'package:app_turismo/Recursos/Models/GestionModel.dart';
import 'package:app_turismo/Recursos/Paginas/Menu.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/ListaInformacion.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    final editController = Get.put(EditGestionController(gestionModel));
    final editControlGestion = Get.find<GetxGestionInformacionController>();

    PickedFile? _pickedFile = null;

    idGestion = controllerGestion.id;
    _nombreInformacion.text = controllerGestion.nombre ?? '';
    _ubicacionC = controllerGestion.ubicacion ?? '';
    _descripcionInformacion.text = controllerGestion.descripcion ?? '';

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
                          //Carge de imagenes funcionalidad.
                          final editController =
                              Get.find<EditGestionController>();
                          _pickedFile = await _picker.getImage(
                              source: ImageSource.gallery);

                          if (_pickedFile != null) {
                            editController.setImage(File(_pickedFile!.path));
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
                          print("Ubicacion: " + _ubicacionC);
                          setState(() {
                            _posicionInformacion.text = _ubicacionC;
                          });
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
                    String errorMensaje = _pickedFile == null
                        ? 'Error falta Fotografia'
                        : 'Error falta Ubicacion';

                    if (_formKey.currentState!.validate()) {
                      if (_pickedFile == null || _ubicacionC.isEmpty) {
                        Get.showSnackbar(GetSnackBar(
                          title: 'Validacion de datos',
                          message: errorMensaje,
                          icon: Icon(Icons.app_registration),
                          duration: Duration(seconds: 4),
                          backgroundColor: Colors.red,
                        ));
                      } else {
                        if (idGestion.isEmpty) {
                          editController.saveGestion(
                              _nombreInformacion.text,
                              _descripcionInformacion.text,
                              _ubicacionC.toString());

                        } else {
                          mensaje = "Se actualizaron los datos";
                          editController.editGestion(
                            idGestion,
                              _nombreInformacion.text,
                              _descripcionInformacion.text,
                              _ubicacionC.toString());
                        }
                        Get.showSnackbar(GetSnackBar(
                          title: 'Registro de informacion',
                          message: mensaje,
                          icon: Icon(Icons.app_registration),
                          duration: Duration(seconds: 4),
                          backgroundColor: Colors.orange.shade400,
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
    setState(() {
      _position = position;
      _ubicacionC = _position.toString();
    });
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
    setState(() {
      _ubicacionC = "";
    });

  }
}
