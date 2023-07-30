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
  /*final GetxSitioTuristico _controllerGetxTurismo =
      Get.put(GetxSitioTuristico());*/

  final nombreController = TextEditingController();
  final tipoTurismoController = TextEditingController();
  final descripcionController = TextEditingController();
  final direccionController = TextEditingController();
  final ubicacionController = TextEditingController();

  final controllerSitio = Get.find<GetxSitioTuristico>();
  final editControlTurismo = Get.find<GextControllerTurismo>();
  final utilsController = Get.find<GetxUtils>();

  bool stateSiteChecked = false;

  List<dynamic>? listFotografias = [];
  List<dynamic>? listContacto = [];
  List<dynamic>? listApertura = [];
  List<dynamic>? listComentarios = [];
  List<dynamic>? listServicios = [];

  bool estadoController = true;

  //String ubicacionController = "Sin Ubicacion";
  String uidUsuarioAcces = "";

  final ImagePicker _picker = ImagePicker();
  int _currentStep = 0;
  bool updateUser = false;
  bool isValid = true;

  @override
  Widget build(BuildContext context) {
    uidUsuarioAcces = editControlTurismo.uidUser;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        reverse: true,
        child: Formulario(context),
      ),
    );
  }

  Widget Formulario(BuildContext context) {
    final listTypeTravel = ["Cultural", "Rural", "Ecoturismo", "Bienestar"];
    final _formKey = GlobalKey<FormState>();
    SitioTuristico sitioTuristico;

    sitioTuristico = controllerSitio.sitioTuristico;

    nombreController.text = sitioTuristico.nombre;
    descripcionController.text = sitioTuristico.descripcion;
    ubicacionController.text = sitioTuristico.ubicacion;
    tipoTurismoController.text = sitioTuristico.tipoTurismo;
    listFotografias = sitioTuristico.foto;

    return Container(
        padding: EdgeInsets.all(10.0),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: BodyApp(),
                )
              ],
            )));
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  Widget buttonContinue(buildContext, details) {
    return Row(
      children: [
        _currentStep <= 1
            ? ElevatedButton(
                onPressed: continued,
                child: const Text("Continuar"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green))
            : ElevatedButton(
                onPressed: cancel,
                child: const Text("Atras"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green))
      ],
    );
  }

  Widget BodyApp() {
    SitioTuristico sitioTuristico;
    sitioTuristico = controllerSitio.sitioTuristico;

    return Container(
      child: Stepper(
        type: StepperType.vertical,
        physics: ScrollPhysics(),
        currentStep: _currentStep,
        onStepTapped: (step) => tapped(step),
        controlsBuilder: buttonContinue,
        steps: <Step>[
          Step(
              title: new Text('Informacion'),
              content: Column(
                children: <Widget>[
                  listTileInformation(nombreController, "Nombre sitio",
                      TextInputType.text, sitioTuristico.nombre),
                  listTileInformation(
                      descripcionController,
                      "Descripcion sitio",
                      TextInputType.text,
                      sitioTuristico.descripcion),
                  listTileInformation(ubicacionController, "Ubicacion sitio",
                      TextInputType.text, sitioTuristico.ubicacion),
                  checkboxState("Estado", sitioTuristico.estado)
                ],
              ),
              isActive: _currentStep >= 0),
          Step(
              title: new Text('Contactos'),
              content: Column(
                children: <Widget>[
                  listTileInformation(direccionController, "Direccion sitio",
                      TextInputType.text, sitioTuristico.direccion),





                ],
              ),
              isActive: _currentStep >= 1),
          Step(
              title: new Text('Contactos'),
              content: Column(
                children: <Widget>[
                  listTileInformation(direccionController, "Direccion sitio",
                      TextInputType.text, sitioTuristico.direccion),
                ],
              ),
              isActive: _currentStep >= 0),
        ],
      ),
    );
  }

  Widget optionCheckbox() {
    return Checkbox(
        value: stateSiteChecked,
        onChanged: (bool? value) {
          setState(() {
            stateSiteChecked = value!;
          });
        });
  }

  Widget TextFieldWidget(TextEditingController controlador, String textGuide,
      String msgError, TextInputType textInputType) {
    return TextFormField(
        controller: controlador,
        keyboardType: textInputType,
        decoration: InputDecoration(
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

  Widget listTileInformation(TextEditingController controller, String title,
      TextInputType textInputType, valorSitio) {
    return ListTile(
        title: Text(title),
        subtitle: updateUser
            ? TextFieldWidget(
                controller, "Nombre", "Digite campo", textInputType)
            : Text(valorSitio));
  }

  Widget checkboxState(String title, bool valorSitio) {
    return ListTile(
        title: Text(title),
        subtitle: updateUser
            ? optionCheckbox()
            : Text(valorSitio ? "Abierto" : "Cerrado"));
  }
}
