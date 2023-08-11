import 'dart:io';

import 'package:app_turismo/Recursos/Controller/GestionController.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GetxGestionInformacion.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GexTurismo.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GextUtils.dart';
import 'package:app_turismo/Recursos/Models/GestionModel.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
  final utilsController = Get.find<GetxUtils>();

  final gestionModel = Get.arguments as GestionModel?;

  final _nombreInformacion = TextEditingController();
  final _posicionInformacion = TextEditingController();
  final _descripcionInformacion = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String idGestion = "";
  String _ubicacionC = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.5, horizontal: 20),
          child: SingleChildScrollView(
            child: FormGestion(),
          )),
    );
  }

  //Fomulario
  Widget FormGestion() {
    final editController = Get.put(EditGestionController());


    _nombreInformacion.text = controllerGestion.nombre;
    _ubicacionC = controllerGestion.ubicacion;
    _descripcionInformacion.text = controllerGestion.descripcion;

    setState(() {
      idGestion = controllerGestion.id;
    });
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
                "Titulo de " + controllerTurismo.typeInformation,
                1,
                "Error, falta nombre",
                TextInputType.text),
            SizedBox(height: 20),
            Text("Descripcion"),
            TextFieldWidget(
                _descripcionInformacion,
                Icon(Icons.description, color: Colors.green),
                "Descripcion " + controllerTurismo.typeInformation,
                3,
                "Error, complete la descripcion",
                TextInputType.text),
            SizedBox(height: 20),
            Text("Carga de fotografias",
                textDirection: TextDirection.rtl,
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 15),
            GetBuilder<GetxGestionInformacionController>(
              init: GetxGestionInformacionController(),
              builder: (controller) {
                return Column(
                  children: [
                    Container(
                        alignment: Alignment.center, child: caruselPhotos()),
                    ElevatedButton.icon(
                      label: Text("Cargar fotos"),
                      onPressed: () => selectMultPhoto(),
                      icon: Icon(Icons.image_outlined, color: Colors.white),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                    )
                  ],
                );
              },
            ),
            SizedBox(height: 10),
            Text("Posicion geografica",
                style: TextStyle(fontWeight: FontWeight.bold)),
            GetBuilder<GetxGestionInformacionController>(
              init: GetxGestionInformacionController(),
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
            SizedBox(height: 35),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                style: Constants.buttonPrimary,
                onPressed: () {
                  String mensaje = "";

                  if (_formKey.currentState!.validate()) {
                    if (_ubicacionC.isEmpty ||
                        controllerGestion.imageFileList.length == 0) {
                      utilsController.messageError(
                          "Validaciones", "Complete informacion requerida.");
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
                            idGestion,
                            _nombreInformacion.text,
                            _descripcionInformacion.text,
                            _ubicacionC.toString());
                      }
                      utilsController.messageInfo("Informacion", mensaje);
                      cleanForm();
                    }
                  }
                },
                child: const Text(
                  'Guardar',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 10),
              idGestion != "" ?
              ElevatedButton(
                onPressed: () => cleanForm(),
                child: Text("Cancelar"),
                style: Constants.buttonCancel,
              ) : Container()
            ]),
          ],
        ));
  }

//Funciones para localizacion
  void _getCurrentLocation() async {
    Position position = await _determinePosition();
    controllerGestion.updateUbicacion(position.toString());
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
    controllerGestion.cleanData();
    idGestion = "";
    setState(() {});
  }

  //Se agrega funcionalidad para carga de fotografia
  selectMultPhoto() async {
    try {
      controllerGestion.imageFileList.clear();
      final List<XFile>? selectedImages = await _picker.pickMultiImage();

      if (selectedImages!.isNotEmpty) {
        validatePhoto(selectedImages);
      }
    } catch (e) {
      utilsController.messageWarning(
          "Fotografias", "No pudimos seleccionar las fotografias");
    }
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
                controllerGestion.addFilesImage(element);
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

  Widget caruselPhotos() {
    List<XFile> listPhotos = controllerGestion.imageFileList;
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
}
