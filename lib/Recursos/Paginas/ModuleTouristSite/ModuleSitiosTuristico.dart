import 'dart:async';
import 'dart:io';

import 'package:app_turismo/Recursos/Controller/GextControllers/GetxGestionInformacion.dart';
import 'package:app_turismo/Recursos/Paginas/ModuleTouristSite/Getx/GetxSitioTuristico.dart';
import 'package:app_turismo/Recursos/Widgets/custom_TextFormField.dart';
import 'package:app_turismo/Recursos/theme/app_theme.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ModuleSitiosTuristicos extends GetView<GetxSitioTuristico> {
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    controller.dropdownActivity;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Formulario(),
    );
  }

  Widget Formulario() {
    return Container(
        padding: EdgeInsets.all(40.0),
        child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Nombre", textDirection: TextDirection.rtl),
                CustomTextFormField(
                    icon: const Icon(BootstrapIcons.info_circle),
                    obscureText: false,
                    textGuide: "Sitio turistico.",
                    msgError: "Campo obligatorio.",
                    textInputType: TextInputType.text,
                    fillColor: AppBasicColors.colorTextFormField,
                    controller: controller.nombreSitio),
                SizedBox(height: 15),
                CustomTextFormField(
                    icon: const Icon(BootstrapIcons.info_circle),
                    obscureText: false,
                    textGuide: "Descripcion del sitio.",
                    msgError: "Campo obligatorio.",
                    textInputType: TextInputType.text,
                    fillColor: AppBasicColors.colorTextFormField,
                    controller: controller.nombreSitio,
                    maxLinesText: 4),
                SizedBox(height: 15),
                Text("Tipo de turismo"),
                ListInformation(controller.tipoTurismo,
                    controller.dropdownItems, "Seleccionar"),
                SizedBox(height: 15),
                Text("Actividades"),
                ListActivity(
                    controller.tipoTurismo, controller.menuItemsActivity),
                SizedBox(height: 15),
                Text("Contactos"),
                CustomTextFormField(
                    icon: const Icon(BootstrapIcons.twitter),
                    obscureText: false,
                    textGuide: "Twitter del sitio",
                    msgError: "",
                    textInputType: TextInputType.text,
                    fillColor: AppBasicColors.colorTextFormField,
                    controller: controller.twitterTextController),
                SizedBox(height: 15),
                CustomTextFormField(
                    icon: const Icon(BootstrapIcons.messenger),
                    obscureText: false,
                    textGuide: "Messenger del sitio",
                    msgError: "",
                    textInputType: TextInputType.text,
                    fillColor: AppBasicColors.colorTextFormField,
                    controller: controller.messengerTextController),
                SizedBox(height: 15),
                CustomTextFormField(
                    icon: const Icon(BootstrapIcons.instagram),
                    obscureText: false,
                    textGuide: "Instagram del sitio",
                    msgError: "",
                    textInputType: TextInputType.text,
                    fillColor: AppBasicColors.colorTextFormField,
                    controller: controller.instagramTextController),
                SizedBox(height: 15),
                CustomTextFormField(
                    icon: const Icon(BootstrapIcons.whatsapp),
                    obscureText: false,
                    textGuide: "Whatsapp del sitio",
                    msgError: "",
                    textInputType: TextInputType.text,
                    fillColor: AppBasicColors.colorTextFormField,
                    controller: controller.whatsappTextController),
                SizedBox(height: 15),
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
                GetBuilder<GetxGestionInformacionController>(
                  init: GetxGestionInformacionController(),
                  builder: (controller) {
                    return Column(
                      children: [
                        Container(
                            alignment: Alignment.center,
                            child: caruselPhotos()),
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
                      child: const Text("Guardar"),
                    )
                  ],
                )
              ],
            )));
  }

  Widget ListInformation(TextEditingController _tipoTurismo,
      List<DropdownMenuItem<String>> listInformation, String hintextValue) {
    return DropdownButtonFormField<String>(
      decoration: AppBasicColors.inputDecorationText,
      isExpanded: true,
      dropdownColor: AppBasicColors.colorTextFormField,
      icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.white),
      items: listInformation,
      onChanged: (String? value) {},
      hint: Text(hintextValue, style: TextStyle(color: Colors.black26)),
    );
  }

  Widget ListActivity(TextEditingController _tipoTurismo,
      List<DropdownMenuItem<String>> listInformation) {
    return DropdownButtonFormField<String>(
      decoration: AppBasicColors.inputDecorationText,
      isExpanded: true,
      dropdownColor: AppBasicColors.colorTextFormField,
      icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.white),
      items: listInformation,
      onChanged: (String? value) {
        print("Valor Activity: ${value}");
      },
      hint: Text('Seleccionar', style: TextStyle(color: Colors.black26)),
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

  selectMultPhoto() async {
    try {
      controller.imageFileList.clear();
      final List<XFile>? selectedImages = await _picker.pickMultiImage();

      if (selectedImages!.isNotEmpty) {
        validatePhoto(selectedImages);
      }
    } catch (e) {
      /*utilsController.messageWarning(
          "Fotografias", "No pudimos seleccionar las fotografias");*/
      print("Eror:");
    }
  }

  Widget caruselPhotos() {
    List<XFile> listPhotos = controller.imageFileList;
    return listPhotos.length == 0
        ? Image.asset(
            "assets/img/photo.png",
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
                controller.addFilesImage(element);
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

    /*utilsController.messageInfo(
        "Validacion", "Fotos seleccionadas y validadas.");*/
  }
}
