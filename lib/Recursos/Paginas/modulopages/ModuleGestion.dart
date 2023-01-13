// ignore_for_file: unused_local_variable, unused_import, deprecated_member_use

import 'dart:io';
import 'package:app_turismo/Recursos/Controller/GestionController.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GexTurismo.dart';
import 'package:app_turismo/Recursos/Models/GestionModel.dart';
import 'package:app_turismo/Recursos/Paginas/Menu.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/ListaInformacion.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

class ModuleGestion extends StatefulWidget {
  const ModuleGestion({Key? key}) : super(key: key);

  @override
  State<ModuleGestion> createState() => _ModuleGestionState();
}

class _ModuleGestionState extends State<ModuleGestion> {
  Position? _position;
  final _nombreInformacion = TextEditingController();
  final _posicionInformacion = TextEditingController();
  String _ubicacionC = "";
  final _descripcionInformacion = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  final GextControllerTurismo controllerTurismo =
  Get.put(GextControllerTurismo());


  @override
  Widget build(BuildContext context) {

    return Center(
        child: SingleChildScrollView(
            child: Formulario()));
  }

  //Fomulario
  Widget Formulario() {

    final culturaToEdit = Get.arguments as GestionModel?;
    final editController = Get.put(EditGestionController(culturaToEdit));
    String titulo = "Nombre de la " + controllerTurismo.typeInformation;
    PickedFile? _pickedFile = null;

    return Container(
      padding: EdgeInsets.all(16.0),
      child: Form(
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Nombre',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 4.0,
            ),
            //textformfield nombre
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: TextFormField(
                      controller: _nombreInformacion,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.sentences,
                      cursorColor: Colors.green.shade300,
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(16.0),
                          fillColor: Colors.white,
                          hintText: titulo,
                          hintStyle: TextStyle(color: Colors.grey.shade300),
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: FaIcon(
                              FontAwesomeIcons.houseUser,
                              color: Colors.green.shade300,
                            ),
                          )),
                      validator: (Value) {
                        if (Value!.isEmpty) {
                          return "Digite informacion requerida";
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            //button imagen
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(5.0),
                  height: 34.0,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        primary: Color(0xFFFFFFFF),
                        onPrimary: Colors.black,
                        elevation: 5.0,
                      ),
                      child: Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.image,
                            color: Colors.green.shade300,
                          ),
                          SizedBox(width: 3),
                          Text('Imagen')
                        ],
                      ),
                      onPressed: () async {
                        //Carge de imagenes funcionalidad.
                        final editController =
                            Get.find<EditGestionController>();
                        _pickedFile =
                            await _picker.getImage(source: ImageSource.gallery);

                        if (_pickedFile != null) {
                          editController.setImage(File(_pickedFile!.path));
                        }
                      }),
                ),
                //textformfield imagen
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: TextFormField(
                    cursorColor: Colors.green.shade300,
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16.0),
                      fillColor: Colors.white,
                      hintText: 'Seleccione una imagen...',
                      hintStyle: TextStyle(color: Colors.grey.shade300),
                    ),
                  ),
                ))
              ],
            ),
            const SizedBox(
              height: 4.0,
            ),
            //button ubicacion
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    onPressed: () {
                      _getCurrentLocation();
                      print("Ubicacion: " + _ubicacionC);
                      setState(() {
                        _posicionInformacion.text = _ubicacionC;
                      });
                      //Logica para buscar ubicacion GPS
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      primary: const Color(0xFFFFFFFF),
                      onPrimary: Colors.black,
                      elevation: 5.0,
                    ),
                    child: Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.locationDot,
                          color: Colors.green.shade300,
                        ),
                        SizedBox(width: 3),
                        Text('Ubicación')
                      ],
                    ),
                  ),
                ),
                // textformfield ubicacion
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: TextFormField(
                      controller: _posicionInformacion,
                      cursorColor: Colors.green.shade300,
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(16.0),
                        fillColor: Colors.white,
                        hintText: 'Ubicación no encontrada',
                        hintStyle: TextStyle(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            //descripcion
            Row(
              children: const [
                Text(
                  'Descripción',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(
              height: 4.0,
            ),
            //textformfield descripcion
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: TextFormField(
                maxLines: 5,
                controller: _descripcionInformacion,
                cursorColor: Colors.green.shade300,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16.0),
                  fillColor: Colors.white,
                  hintText: 'Descripcion formal.',
                  hintStyle: TextStyle(color: Colors.grey.shade300),
                ),
                validator: (value) {
                  if (value!.isEmpty) return "Digite una descripcion ";
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('100 caracteres',
                    style: TextStyle(color: Colors.grey.shade400))
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            //button guardar
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      primary: Colors.green.shade300,
                      onPrimary: Colors.black,
                      elevation: 5.0,
                    ),
                    onPressed: () {
                      //Logica para guardar el registro.
                      print("Nombre: " +  _nombreInformacion.text);
                      print("Ubicacion: " +  _ubicacionC.toString());
                      print("Descripcion: " +  _descripcionInformacion.toString());

                      if (_nombreInformacion.text.isEmpty || _ubicacionC.toString().isEmpty
                      || _descripcionInformacion.toString().isEmpty || _pickedFile == null) {

                        print("Error campos vacios");
                        Get.showSnackbar(const GetSnackBar(
                          title: 'Validacion de datos',
                          message: 'Error datos faltantes',
                          icon: Icon(Icons.app_registration),
                          duration: Duration(seconds: 4),
                          backgroundColor: Colors.red,
                        ));
                      } else {
                        editController.saveGestion(
                            _nombreInformacion.text,
                            _descripcionInformacion.text,
                            _ubicacionC.toString());
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 12.0),
                      child: const Text(
                        'Guardar',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
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
}
