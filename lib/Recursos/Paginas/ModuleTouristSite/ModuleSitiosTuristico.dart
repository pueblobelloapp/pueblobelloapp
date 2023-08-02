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

class ModuleSitiosTuristicos extends GetView<GextControllerTurismo> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Formulario(),
    );
  }

  Widget Formulario() {
    final listTypeTravel = ["Cultural", "Rural", "Ecoturismo", "Bienestar"];

    return Container(
        padding: EdgeInsets.all(40.0),
        child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("Nombre", textDirection: TextDirection.rtl),
                textForm(controller.nombreST, "Nombre sitio turistico", 1,
                    TextInputType.name),
                SizedBox(height: 15),
                Text("Tipo de turismo"),
                ListInformation(controller.tipoTurismo, dropdownItems),
                SizedBox(height: 15),
                Text("Actividades"),
                ListInformation(controller.tipoTurismo, dropdownItemsServices),
                SizedBox(height: 15),
                Text("Contactos"),
                ListSocial(controller.tipoTurismo, dropdownItemsSocial),
                SizedBox(height: 15),
                Text("Descripcion", textDirection: TextDirection.rtl),
                textForm(controller.descripcionST, "Descripcion del sitio", 5,
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
                Text(controller.ubicacionST),
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
                        controller.validateForms();
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

  Widget ListInformation(TextEditingController _tipoTurismo,
      List<DropdownMenuItem<String>> listInformation) {
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
      items: listInformation,
      onChanged: (String? value) {},
      hint: Text(
        'Seleccionar',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget ListSocial(TextEditingController _tipoTurismo,
      List<DropdownMenuItem<String>> listInformation) {
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
      items: listInformation,
      onChanged: (String? value) {},
      hint: Text(
        'Seleccionar',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  //Funciones para localizacion
  void _getCurrentLocation() async {
    Position position = await _determinePosition();
    controller.ubicacionST = position.toString();
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

  List<DropdownMenuItem<String>> get dropdownItemsServices {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Senderismo"), value: "test1"),
      DropdownMenuItem(child: Text("Cabalgatas"), value: "test2"),
      DropdownMenuItem(child: Text("Caminatas"), value: "test3"),
      DropdownMenuItem(child: Text("Test 1"), value: "test4"),
      DropdownMenuItem(child: Text("Test2"), value: "test5"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownItemsSocial {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: checkRedSocial("Facebook"), value: "test1"),
      DropdownMenuItem(child: Text("Cabalgatas"), value: "test2"),
      DropdownMenuItem(child: Text("Caminatas"), value: "test3"),
      DropdownMenuItem(child: Text("Test 1"), value: "test4"),
      DropdownMenuItem(child: Text("Test2"), value: "test5"),
    ];
    return menuItems;
  }

  Widget checkRedSocial(String valueText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(valueText),
        Checkbox(
          checkColor: Colors.white,
          value: true,
          onChanged: (bool? value) {
            if (value!) {
              controller.isChecked.value = true;
            } else {
              controller.isChecked.value = false;
            }
          },
        )
      ],
    );
  }
}
