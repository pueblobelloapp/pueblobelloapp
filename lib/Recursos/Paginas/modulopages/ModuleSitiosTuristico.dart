import 'dart:async';
import 'dart:io';

import 'package:app_turismo/Recursos/Constants/Constans.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GetxSitioTuristico.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GexTurismo.dart';
import 'package:app_turismo/Recursos/Controller/SitesController.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GextUtils.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ModuleSitiosTuristicos extends StatelessWidget {
  final GetxSitioTuristico _controllerGetxTurismo =
      Get.put(GetxSitioTuristico());

  final _nombreST = TextEditingController();
  final _tipoTurismo = TextEditingController();
  final _capacidadST = TextEditingController();
  final _descripcionST = TextEditingController();


  final editControlSitioTurismo = Get.find<GetxSitioTuristico>();
  final editControlTurismo = Get.find<GextControllerTurismo>();
  final utilsController = Get.find<GetxUtils>();

  List<dynamic>? fotografias = [];
  String _ubicacionST = "Sin Ubicacion";
  String _uidUser = "";
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    _uidUser = editControlTurismo.uidUser;

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
    _nombreST.text = _controllerGetxTurismo.nombre;
    _descripcionST.text = _controllerGetxTurismo.descripcion;
    _capacidadST.text = _controllerGetxTurismo.capacidad;
    _ubicacionST = _controllerGetxTurismo.ubicacion;
    _tipoTurismo.text = _controllerGetxTurismo.tipoTurismo;
    fotografias = _controllerGetxTurismo.fotoUrl;

    return Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Nombre",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                textForm(
                    _nombreST, "Nombre sitio turistico", 1, TextInputType.name),
                SizedBox(height: 15),
                Text("Tipo de turismo",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                ListTravel(_tipoTurismo, listTypeTravel),
                SizedBox(height: 15),
                Text("Capacidad personas",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                textForm(
                    _capacidadST, "Cantidad personas", 1, TextInputType.number),
                SizedBox(height: 15),
                Text("Descripcion",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                textForm(_descripcionST, "Descripcion del sitio", 5,
                    TextInputType.name),
                SizedBox(height: 15),
                Text("Carga de fotografias",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 15),
                GetBuilder<GetxSitioTuristico>(
                  init: GetxSitioTuristico(),
                  builder: (controller) {
                    return Column(
                      children: [
                        Container(
                            alignment: Alignment.center,
                            child: caruselPhotos()),
                        TextButton(
                            onPressed: () {
                              selectMultPhoto();
                            },
                            child: Text("Seleccionar",
                              style: TextStyle(color: Colors.green),
                            ))
                      ],
                    );
                  },
                ),
                Text("Ubicacion geografica",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                GetBuilder<GetxSitioTuristico>(
                  init: GetxSitioTuristico(),
                  builder: (controller) {
                    return Text('${controller.ubicacion}');
                  },
                ),
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
                GetBuilder<GetxSitioTuristico>(
                  init: GetxSitioTuristico(),
                  builder: (controller) {
                    return buttonOption( _formKey );
                  },
                ),
              ],
            )));
  }
  selectMultPhoto() async {
    try {
      editControlSitioTurismo.imageFileList.clear();
      final List<XFile>? selectedImages = await _picker.pickMultiImage();

      if (selectedImages!.isNotEmpty) {
        validatePhoto(selectedImages);
      }
    } catch (e) {
      utilsController.messageWarning(
          "Fotografias", "No pudimos seleccionar las fotografias");
    }
  }
  Widget caruselPhotos() {
    List<XFile> listPhotos = editControlSitioTurismo.imageFileList;
    return listPhotos.length == 0
        ? Image.asset(
            "assets/Icons/photo.png",
            width: 60,
            height: 60,
          )
        : CarouselSlider(
            options: CarouselOptions(),
            items: listPhotos
                .map((photo) => Container(
                    child: Center(child: Image.file(File(photo.path)))))
                .toList());
  }
  Widget buttonOption(GlobalKey<FormState> formKey) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            if (utilsController.isReadyAction) {
              utilsController.updateAction(false);
            }

            if (formKey.currentState!.validate() &&
                editControlSitioTurismo.tipoTurismo != "Seleccionar" &&
                _controllerGetxTurismo.ubicacion != "Sin Ubicacion" &&
                _controllerGetxTurismo.ubicacion != "Realizando ubicacion"
            ) {
              actionButton();
            } else {
              utilsController.messageError(
                  "Campos faltantes", "Complete todos los campos");
            }
            utilsController.updateAction(true);
          },
          style: Constants.buttonPrimary,
          child: GetBuilder<GetxUtils>(
            init: GetxUtils(),
            builder: (controller) {
              return  controller.isReadyAction ?
              Text(_controllerGetxTurismo.buttonText.toString()) :
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.white),
                  const SizedBox(width: 10),
                  Text("Espere, por favor...")
                ],
              );
            },
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Visibility(
            visible:
                _controllerGetxTurismo.buttonText.toString() == "Actualizar"
                    ? true
                    : false,
            child: ElevatedButton(
              onPressed: () {
                cleanForm();
              },
              child: Text("Cancelar"),
              style: Constants.buttonCancel,
            ))
      ],
    );
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
          fillColor: Colors.grey.shade300,
          filled: true,
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.green)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          hintText: HintText,
          labelStyle: TextStyle(color: Colors.green),
        ),
      validator: (value) {
          if (value!.isEmpty) {
            return 'Por favor, ingrese un texto.';
          }
      },

    );
  }
  Widget ListTravel(
      TextEditingController _tipoTurismo, List<String> listTypeCulture) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(12.0),
        ),
        dropdownColor: Colors.green.shade300,
        icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.white),
        items: listTypeCulture.map((listTypeCulture) {
          return DropdownMenuItem(
              value: listTypeCulture,
              child: Text(
                'Turismo $listTypeCulture',
                style: TextStyle(color: Colors.black),
              ));
        }).toList(),
        onChanged: ((value) => _tipoTurismo.text = "Turismo " + value!),
        hint: GetBuilder<GetxSitioTuristico>(
          init: GetxSitioTuristico(),
          builder: (controller) {
            return Text(controller.tipoTurismo.isEmpty
                ? "Seleccionar"
                : '${controller.tipoTurismo}');
          },
        ),
      ),
    );
  }
  void _getCurrentLocation() async {
    Position position = await _determinePosition();
    final GetxSitioTuristico _controllerGetxTurismo =
        Get.put(GetxSitioTuristico());

    _controllerGetxTurismo.updateUbicacion(position.toString());
    _ubicacionST = position.toString();
    utilsController.messageInfo("Ubicacion", "Ubicacion actualizada");
  }
  void cleanForm() {
    _controllerGetxTurismo.cleanTurismo();
    _controllerGetxTurismo.imageFileList.clear();
    _controllerGetxTurismo.updateUbicacion("Sin Ubicacion");
    _nombreST.clear();
    _capacidadST.clear();
    _descripcionST.clear();
    _tipoTurismo.clear();
    _ubicacionST = "Sin ubicacion";
  }
  void validatePhoto(List<XFile> photos) {
    photos.forEach((element) {
      Image image = Image.file(File(element.path));
      image.image.resolve(ImageConfiguration()).addListener(
        ImageStreamListener(
              (ImageInfo image, bool synchronousCall) {
            var myImage = image.image;
            if (myImage.width.toDouble() >= 1024 &&
                myImage.width.toDouble() <= 1080) {
              if (myImage.height.toDouble() >= 566 &&
                  myImage.height.toDouble() <= 1080) {
                editControlSitioTurismo.addFilesImage(element);
              } else {
                photos.remove(element);
              }
            } else {
              photos.remove(element);
            }
          },
        ),
      );
    });

    utilsController.messageInfo(
        "Validacion", "Fotos seleccionadas y validadas.");
  }
  void actionButton() {
    print("Action buttton");
    final editController = Get.find<EditSitesController>();
    if (_controllerGetxTurismo.id != "") {
      print("Update Data");
      editController.editSite(
          _controllerGetxTurismo.id,
          _nombreST.text,
          _capacidadST.text,
          _tipoTurismo.text,
          _descripcionST.text,
          _ubicacionST.toString(),
          _uidUser,
          fotografias);
    } else {
      print("Guardando");
      if ( editControlSitioTurismo.imageFileList.length > 0 ) {
        editController.saveSite(
            _nombreST.text,
            _capacidadST.text,
            _tipoTurismo.text,
            _descripcionST.text,
            _ubicacionST.toString(),
            _uidUser);
      } else {
        utilsController.messageError(
            "Fotos", "Seleccione fotografias del sitio.");
      }

    }
    cleanForm();
  }
  Future<Position> _determinePosition() async {
    final GetxSitioTuristico _controllerGetxTurismo =
        Get.put(GetxSitioTuristico());
    _controllerGetxTurismo.updateUbicacion("Realizando ubicacion");

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
