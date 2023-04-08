import 'dart:io';

import 'package:app_turismo/Recursos/Constants/Constans.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GextPropietarioController.dart';
import 'package:app_turismo/Recursos/Controller/PropietarioController.dart';
import 'package:app_turismo/Recursos/Models/PropietarioModel.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

const List<String> list = <String>['Masculino', 'Femenino'];

class ModulePropietario extends StatefulWidget {
  const ModulePropietario({Key? key}) : super(key: key);
  @override
  State<ModulePropietario> createState() => _ModulePropietarioState();
}

class _ModulePropietarioState extends State<ModulePropietario> {
  final GextPropietarioController controllerPropietario =
      Get.put(GextPropietarioController());

  final _nombrePropietario = TextEditingController();
  final _sitioTuristicoPropietario = TextEditingController();
  final _correoPropietario = TextEditingController();
  final _edadPropietario = TextEditingController();
  final _contactoPropietario = TextEditingController();
  final _passwordPropietario = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  String dropdownValue = list.first;
  String _tipoGenero = "";
  String _uiPropietario = "000";
  final propietarioToEdit = Get.arguments as Propietario?;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Container(padding: EdgeInsets.all(30.0), child: Formulario()),
      ),
    );
  }

  Widget Formulario() {
    _uiPropietario = controllerPropietario.id;
    _nombrePropietario.text = controllerPropietario.nombre;
    _sitioTuristicoPropietario.text =
        controllerPropietario.sitioTuristico;
    _correoPropietario.text = controllerPropietario.correo;
    _edadPropietario.text = controllerPropietario.edad;
    _contactoPropietario.text = controllerPropietario.contacto;

    XFile? image = null;

    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Nombre"),
            TextFieldWidget(
                _nombrePropietario,
                FaIcon(FontAwesomeIcons.user, color: Colors.green),
                "Nombre del propietario",
                "Error, digite nombre del propietario.",
                TextInputType.text),
            SizedBox(height: 10),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text("Edad"),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: TextFieldWidget(
                            _edadPropietario,
                            FaIcon(FontAwesomeIcons.addressCard,
                                color: Colors.green),
                            "edad",
                            "Error, campo vacio.",
                            TextInputType.number),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text("Genero"),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          icon: FaIcon(
                            size: 20,
                            FontAwesomeIcons.angleDown,
                            color: Colors.green,
                          ),
                          elevation: 16,
                          style: TextStyle(color: Colors.grey.shade700),
                          isExpanded: true,
                          onChanged: (String? value) {
                            setState(() {
                              dropdownValue = value!;
                              _tipoGenero = value;
                            });
                          },
                          items: list
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(fontSize: 17),
                              ),
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Text("Correo electronico"),
            TextFieldWidget(
                _correoPropietario,
                FaIcon(FontAwesomeIcons.envelope, color: Colors.green),
                "Correo electronico.",
                "Error, correo electronico del propietario.",
                TextInputType.text),
            SizedBox(height: 10),
            Text("Contraseña"),
            TextFieldWidget(
                _passwordPropietario,
                FaIcon(FontAwesomeIcons.key, color: Colors.green),
                "Contraseña.",
                "Error, ingrese contraseña.",
                TextInputType.text),
            SizedBox(height: 10),
            Text("Numero telefonico"),
            TextFieldWidget(
                _contactoPropietario,
                FaIcon(FontAwesomeIcons.phone, color: Colors.green),
                "Numero telefonico.",
                "Error, Numero telefonico del propietario.",
                TextInputType.numberWithOptions(decimal: false)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton.icon(
                    icon: FaIcon(FontAwesomeIcons.image),
                    style: Constants.buttonPrimary,
                    onPressed: () async {
                      final editController = Get.find<PropietarioController>();

                      image =
                          await _picker.pickImage(source: ImageSource.gallery);

                    },
                    label: const Text('Subir Imagenes',
                        textAlign: TextAlign.center)),
                ElevatedButton.icon(
                    icon: FaIcon(FontAwesomeIcons.floppyDisk),
                    style: Constants.buttonPrimary,
                    onPressed: () {
                      final editController = Get.find<PropietarioController>();
                      if (_formKey.currentState!.validate()) {

                        if (_uiPropietario.isEmpty) {
                          //Actualizamos
                          editController.editSite(
                            _uiPropietario,
                              "Propietario",
                              _nombrePropietario.text,
                              _sitioTuristicoPropietario.text,
                              _edadPropietario.text,
                              _tipoGenero.toString(),
                              _correoPropietario.text,
                          );
                        }

                        setState(() {});
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.black,
                                duration: Duration(seconds: 2),
                                content: Text('Procesando informacion')));
                      } else {
                        print("Datos Incorrectos");
                      }
                    },
                    label: Text("Actualizar",
                        textAlign: TextAlign.center))
              ],
            ),
          ],
        ));
  }

  Widget TextFieldWidget(TextEditingController controlador, FaIcon icono,
      String textGuide, String msgError, TextInputType textInputType) {
    return TextFormField(
        controller: controlador,
        keyboardType: textInputType,
        decoration: InputDecoration(
          prefixIcon: Padding(padding: EdgeInsets.all(12.0), child: icono),
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

  void formClean() {
    _nombrePropietario.clear();
    _contactoPropietario.clear();
    _correoPropietario.clear();
    _edadPropietario.clear();
    _sitioTuristicoPropietario.clear();
  }

}
