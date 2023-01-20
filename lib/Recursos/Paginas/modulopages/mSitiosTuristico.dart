// ignore_for_file: unnecessary_null_comparison, deprecated_member_use, unused_local_variable, unused_import, unnecessary_import

import 'dart:io';

import 'package:app_turismo/Recursos/Controller/GextControllers/GexTurismo.dart';
import 'package:app_turismo/Recursos/Controller/SitesController.dart';
import 'package:app_turismo/Recursos/Models/SiteTuristico.dart';
import 'package:app_turismo/Recursos/Paginas/GoogleLocation.dart';
import 'package:app_turismo/Recursos/Paginas/Menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

class MsitiosTuristico extends StatefulWidget {
  const MsitiosTuristico({Key? key}) : super(key: key);

  @override
  State<MsitiosTuristico> createState() => _MsitiosTuristicoState();
}

class _MsitiosTuristicoState extends State<MsitiosTuristico> {
  Position? _position;
  final _nombreST = TextEditingController();
  final _tipoTurismo = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final _capacidadST = TextEditingController();
  String _ubicacionST = "";
  final _descripcionST = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final siteToEdit = Get.arguments as SitioTuristico?;
    final editController = Get.put(EditSitesController(siteToEdit));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MenuModuls()));
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
            )),
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.output_sharp,
                color: Colors.black,
              )),
        ],
        title: Align(
          child: Text(
            'Módulo sitios turístico',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          alignment: Alignment.center,
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Formulario(),
      ),
    );
  }

  Widget Formulario() {
    final listTypeTravel = ["Cultural", "Rural", "Ecoturismo", "Bienestar"];

    return Container(
        padding: EdgeInsets.all(40.0),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("Nombre", textDirection: TextDirection.rtl),
                textForm(
                    _nombreST, "Nombre sitio turistico", 1, TextInputType.name),
                SizedBox(height: 15),
                Text("Tipo de turismo"),
                ListTravel(_tipoTurismo, listTypeTravel),
                SizedBox(height: 15),
                Text("Capacidad personas"),
                //textForm(_capacidadST, "tEXTO", 1)
                textForm(
                    _capacidadST, "Cantidad personas", 1, TextInputType.number),
                SizedBox(height: 15),
                Text(
                  "Descripcion",
                  textDirection: TextDirection.rtl,
                ),
                textForm(_descripcionST, "Descripcion del sitio", 5,
                    TextInputType.name),
                SizedBox(height: 15),
                Text(
                  "Carga de fotografias",
                  textDirection: TextDirection.rtl,
                ),
                TextButton.icon(
                    onPressed: () async {
                      final editController = Get.find<EditSitesController>();
                      PickedFile? _pickedFile =
                          await _picker.getImage(source: ImageSource.gallery);
                      if (_pickedFile != null) {
                        editController.setImage(File(_pickedFile.path));
                      }
                    },
                    icon: Icon(
                      Icons.photo,
                      color: Colors.green,
                    ),
                    label: Text(
                      "Seleccionar",
                      style: TextStyle(color: Colors.green),
                    )),
                Text("Ubicacion geografica"),
                Text(_ubicacionST),
                TextButton.icon(
                    onPressed: () {
                      _getCurrentLocation();

                    },
                    icon: Icon(
                      Icons.location_on,
                      color: Colors.green,
                    ),
                    label: Text(
                      "Ubicar",
                      style: TextStyle(color: Colors.green),
                    )),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        final editController = Get.find<EditSitesController>();

                        if (_nombreST.text.isEmpty ||
                            _capacidadST.text.isEmpty ||
                            _tipoTurismo.text.isEmpty ||
                            _tipoTurismo.text.isEmpty ||
                            _descripcionST.text.isEmpty ||
                            _ubicacionST.isEmpty) {
                          print("Error campos vacios");
                          Get.showSnackbar(const GetSnackBar(
                            title: 'Validacion de datos',
                            message: 'Error datos faltantes',
                            icon: Icon(Icons.app_registration),
                            duration: Duration(seconds: 4),
                            backgroundColor: Colors.red,
                          ));
                        } else {
                          editController.saveSite(
                              _nombreST.text,
                              _capacidadST.text,
                              _tipoTurismo.text,
                              _descripcionST.text,
                              _position.toString());
                        }
                      },
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.green,
                          textStyle: const TextStyle(fontSize: 15)),
                      child: const Text("REGISTRAR"),
                    )
                  ],
                )
              ],
            )));
  }

  Widget textForm(TextEditingController _controller, String HintText,
      int LinesMax, TextInputType textInputType) {
    return TextFormField(
        controller: _controller,
        maxLines: LinesMax,
        keyboardType: textInputType,
        textCapitalization: TextCapitalization.sentences,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16.0),
          filled: true,
          fillColor: Colors.green.shade300,
          hintText: HintText,
          hintStyle: TextStyle(color: Colors.white),
        ));
  }

  Widget ListTravel(
      TextEditingController _tipoTurismo, List<String> listTypeCulture) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.green.shade300,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: EdgeInsets.all(16.0),
      ),
      isExpanded: true,
      dropdownColor: Colors.green.shade300,
      icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.white),
      items: listTypeCulture.map((listTypeCulture) {
        return DropdownMenuItem(
            value: listTypeCulture,
            child: Text(
              'Turismo $listTypeCulture',
              style: TextStyle(color: Colors.white),
            ));
      }).toList(),
      onChanged: ((value) => setState(() {
            _tipoTurismo.text = "Turismo";
            _tipoTurismo.text += value!;
          })),
      hint: Text(
        'Seleccione un tipo de turismo',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  //Funciones para localizacion
  void _getCurrentLocation() async {
    Position position = await _determinePosition();
    setState(() {
      _position = position;
      _ubicacionST = _position.toString();
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
