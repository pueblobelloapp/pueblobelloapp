import 'dart:async';
import 'dart:io';

import 'package:app_turismo/Recursos/Constants/Constans.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GexTurismo.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GextUtils.dart';
import 'package:app_turismo/Recursos/Models/SiteTuristico.dart';
import 'package:app_turismo/Recursos/Paginas/ModuleTouristSite/Controller/SitesController.dart';
import 'package:app_turismo/Recursos/Paginas/ModuleTouristSite/Getx/GetxSitioTuristico.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ModuleSitiosTuristicos extends StatefulWidget {
  @override
  State<ModuleSitiosTuristicos> createState() => _ModuleSitiosTuristicosState();
}

class _ModuleSitiosTuristicosState extends State<ModuleSitiosTuristicos> {

  Position? _position;
  final _nombreST = TextEditingController();
  final _tipoTurismo = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final _capacidadST = TextEditingController();
  final _descripcionST = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _ubicacionST = "";
  String _uidUser = "";

  @override
  Widget build(BuildContext context) {
    final siteToEdit = Get.arguments as SitioTuristico?;
    final GextControllerTurismo _controllerTurismo =
    Get.put(GextControllerTurismo());
    final editControlTurismo = Get.find<GextControllerTurismo>();
    _uidUser = editControlTurismo.uidUser;

    return  SingleChildScrollView(
        reverse: true,
        child: Formulario(),
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
                    onPressed: () async {},
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
                          print("Turismo registrado con : " + _uidUser);
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
