import 'dart:io';

import 'package:app_turismo/Recursos/Controller/GextControllers/GetxInformationMunicipio.dart';
import 'package:app_turismo/Recursos/Models/InfoMunicipio.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/ImageUpload.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/MapGeolocation.dart';
import 'package:app_turismo/Recursos/Widgets/custom_TextFormField.dart';
import 'package:app_turismo/Recursos/theme/app_theme.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Controller/GextControllers/GetxSitioTuristico.dart';
import '../../Controller/GextControllers/PhotoLoad.dart';

class InformationMunicipio extends GetView<GetxInformationMunicipio> {
  final GetxSitioTuristico sitioController = Get.put(GetxSitioTuristico());
  final PhotoLoad photoLoad1 = Get.put(PhotoLoad());
  final PhotoLoad photoLoad2 = Get.put(PhotoLoad());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      reverse: true,
      child: Formulario(),
    );
  }

  Widget Formulario() {
    return Form(
        child: Column(
      children: [
        _containerPhoto(photoLoad: photoLoad1),
        SizedBox(height: 15),
        Row(
          children: [
            Text(
              'Título informativo',
              style: TextStyle(color: AppBasicColors.green, fontSize: 16.0),
            ),
          ],
        ),
        SizedBox(height: 3),
        CustomTextFormField(
            //icon: const Icon(BootstrapIcons.info_circle),
            obscureText: false,
            textGuide: "Ingrese el título",
            msgError: "Campo obligatorio.",
            textInputType: TextInputType.text,
            fillColor: AppBasicColors.colorTextFormField,
            controller: controller.tituloControl,
            valueFocus: false),
        SizedBox(height: 10),
        Row(
          children: [
            Text(
              'Subtítulo informativo',
              style: TextStyle(color: AppBasicColors.green, fontSize: 16.0),
            ),
          ],
        ),
        SizedBox(height: 3),
        CustomTextFormField(
            //icon: const Icon(BootstrapIcons.info_circle),
            obscureText: false,
            textGuide: "Ingrese el subtítulo informativo",
            msgError: "Campo obligatorio.",
            textInputType: TextInputType.text,
            fillColor: AppBasicColors.colorTextFormField,
            controller: controller.tituloControl,
            valueFocus: false),
        SizedBox(height: 10),
        Row(
          children: [
            Text(
              'Descripción informativa',
              style: TextStyle(color: AppBasicColors.green, fontSize: 16.0),
            ),
          ],
        ),
        SizedBox(height: 3),
        CustomTextFormField(
            //icon: const Icon(BootstrapIcons.info_circle),
            obscureText: false,
            textGuide: "Ingrese la descripción",
            msgError: "Campo obligatorio.",
            textInputType: TextInputType.text,
            fillColor: AppBasicColors.colorTextFormField,
            controller: controller.descriptionControl,
            valueFocus: false,
            maxLinesText: 6),
        SizedBox(height: 10),
        /*CustomTextFormField(
            //icon: const Icon(BootstrapIcons.info_circle),
            obscureText: false,
            textGuide: "Porque vistar?",
            msgError: "Campo obligatorio.",
            textInputType: TextInputType.text,
            fillColor: AppBasicColors.colorTextFormField,
            controller: controller.whyVisitControl,
            valueFocus: false,
            maxLinesText: 4),*/
        //SizedBox(height: 15),
        /*ListInformation(controller.subCategoria, controller.dropdownItems, "Seleccionar"),*/
        //SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ubicación',
              style: TextStyle(color: AppBasicColors.green, fontSize: 16.0),
            ),
            ElevatedButton.icon(
                onPressed: () {
                  Get.to(() => MapGeolocation());
                },
                icon: Icon(BootstrapIcons.pin_map_fill, color: Colors.white),
                label: Text("Obtener la ubicación actual")),
          ],
        ),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: 250,
          color: AppBasicColors.colorTextFormField,
          child: Center(
            child: Text('Aquí se ilustra la ubicación'),
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Información adicional',
              style: TextStyle(color: AppBasicColors.green, fontSize: 16.0),
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  BootstrapIcons.plus_square_fill,
                  size: 30.0,
                  color: AppBasicColors.green,
                ))
          ],
        ),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppBasicColors.colorTextFormField,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3))
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _containerPhoto(
                    photoLoad: photoLoad2,
                    backgroundColor: AppBasicColors.white,
                    height: 250),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'Título',
                      style: TextStyle(
                          color: AppBasicColors.green,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 3),
                CustomTextFormField(
                    //icon: const Icon(BootstrapIcons.info_circle),
                    obscureText: false,
                    textGuide: "Título",
                    msgError: "Campo obligatorio.",
                    textInputType: TextInputType.text,
                    fillColor: AppBasicColors.white,
                    controller: controller.subTituloControl,
                    valueFocus: false),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'Descripción',
                      style: TextStyle(
                          color: AppBasicColors.green,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 3),
                CustomTextFormField(
                    //icon: const Icon(BootstrapIcons.info_circle),
                    obscureText: false,
                    textGuide: "Ingrese la descripción",
                    msgError: "Campo obligatorio.",
                    textInputType: TextInputType.text,
                    fillColor: AppBasicColors.white,
                    controller: controller.subDescriptionControl,
                    valueFocus: false,
                    maxLinesText: 6),
              ],
            ),
          ),
        ),
        /*Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
                onPressed: () {
                  Get.to(() => MapGeolocation());
                },
                icon: Icon(Icons.location_on, color: Colors.white),
                label: Text("Ubicar")),
            SizedBox(width: 10),
            ElevatedButton.icon(
              label: Text("Fotografias"),
              onPressed: () async {
                await Get.to(() => ImageUpload());
                if (sitioController.listCroppedFile.length > 0) {
                  controller.addPhotosGeneral(sitioController.listCroppedFile);
                } else {
                  print("No seleccionaste fotografias.");
                }
                sitioController.listCroppedFile.clear();
              },
              icon: Icon(Icons.image_outlined, color: Colors.white),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            )
          ],
        ),*/

        //SizedBox(height: 7),
        /*ElevatedButton.icon(
            label: Text("Cargar fotos"),
            onPressed: () async {
              await Get.to(() => ImageUpload());
              if (sitioController.listCroppedFile.length > 0) {
                controller.addPhotosSub(sitioController.listCroppedFile);
              } else {
                print("No seleccionaste fotografias.");
              }
              sitioController.listCroppedFile.clear();
            },
            icon: Icon(Icons.image_outlined, color: Colors.white)),*/
        /*Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Informacion adicional : 0"),
            ElevatedButton.icon(
                onPressed: () {
                  controller.addSubinformation();
                  sitioController.listCroppedFile.clear();
                  print("agregando SUb info");
                },
                icon: const Icon(BootstrapIcons.save),
                label: Text("Añadir"))
          ],
        ),*/
        SizedBox(height: 15),
        /*ElevatedButton.icon(
            onPressed: () {
              InfoMunicipio infoMunicipio = InfoMunicipio(
                  nombre: controller.tituloControl.text,
                  descripcion: controller.descriptionControl.text,
                  subTitulos: controller.listSubInformation,
                  ubicacion: sitioController.mapUbications,
                  photos: controller.listPhotosInfo,
                  subCategoria: controller.subCategoria.text,
                  whyVisit: controller.whyVisitControl.text,
                  id: controller.uidGenerate());

              controller.saveGestion(infoMunicipio);
            },
            icon: const Icon(BootstrapIcons.upload),
            label: Text("Guardar")),
        SizedBox(height: 5),*/
        SizedBox(
            width: double.infinity,
            height: 50.0,
            child: ElevatedButton(
                onPressed: () {
                  InfoMunicipio infoMunicipio = InfoMunicipio(
                      nombre: controller.tituloControl.text,
                      descripcion: controller.descriptionControl.text,
                      subTitulos: controller.listSubInformation,
                      ubicacion: sitioController.mapUbications,
                      photos: controller.listPhotosInfo,
                      subCategoria: controller.subCategoria.text,
                      whyVisit: controller.whyVisitControl.text,
                      id: controller.uidGenerate());

                  controller.saveGestion(infoMunicipio);
                },
                child: Text(
                  'Guardar',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                )))
      ],
    ));
  }

  Widget _containerPhoto({
    required PhotoLoad photoLoad,
    Color? backgroundColor,
    double? height,
  }) {
    return GestureDetector(
      onTap: () {
        photoLoad.selectPhoto();
      },
      child: Obx(() => Container(
            width: double.infinity,
            height: height ?? 350,
            decoration: BoxDecoration(
                color: backgroundColor ??
                    (photoLoad.selectedPhoto.value.path == ""
                        ? AppBasicColors.colorTextFormField
                        : AppBasicColors.transparent),
                borderRadius: BorderRadius.circular(10.0)),
            child: Center(
                child: photoLoad.selectedPhoto.value.path != ""
                    ? Image.memory(
                        File(photoLoad.selectedPhoto.value.path)
                            .readAsBytesSync(),
                        fit: BoxFit.cover,
                      )
                    : const Icon(
                        BootstrapIcons.image_alt,
                        size: 100,
                        color: Colors.green,
                      )),
          )),
    );
  }

  Widget ListInformation(TextEditingController _tipoTurismo,
      List<DropdownMenuItem<String>> listInformation, String hintextValue) {
    return DropdownButtonFormField<String>(
      decoration: AppBasicColors.inputDecorationText,
      isExpanded: true,
      dropdownColor: AppBasicColors.colorTextFormField,
      icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.white),
      items: listInformation,
      onChanged: (String? value) {
        print("Valor combo: " + value.toString());
        controller.subCategoria.text = value!;
      },
      hint: Text(hintextValue, style: TextStyle(color: Colors.black26)),
    );
  }
}
