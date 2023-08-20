import 'dart:async';
import 'dart:io';

import 'package:app_turismo/Recursos/Controller/GextControllers/GetxGestionInformacion.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GexTurismo.dart';
import 'package:app_turismo/Recursos/Paginas/ModuleTouristSite/Getx/GetxSitioTuristico.dart';
import 'package:app_turismo/Recursos/Paginas/ModuleTouristSite/MapGeolocation.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/ImageUpload.dart';
import 'package:app_turismo/Recursos/Widgets/custom_TextFormField.dart';
import 'package:app_turismo/Recursos/theme/app_theme.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ModuleSitiosTuristicos extends GetView<GetxSitioTuristico> {
  final ImagePicker _picker = ImagePicker();
  final GextControllerTurismo controllerTurismo =
      Get.put(GextControllerTurismo());

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
                    controller: controller.nombreSitio,
                    valueFocus: true),
                SizedBox(height: 15),
                CustomTextFormField(
                    icon: const Icon(BootstrapIcons.info_circle),
                    obscureText: false,
                    textGuide: "Descripcion del sitio.",
                    msgError: "Campo obligatorio.",
                    textInputType: TextInputType.text,
                    fillColor: AppBasicColors.colorTextFormField,
                    controller: controller.descripcionST,
                    maxLinesText: 4),
                SizedBox(height: 15),
                Text("Tipo de turismo"),
                ListInformation(controller.tipoTurismo,
                    controller.dropdownItems, "Seleccionar"),
                SizedBox(height: 15),
                Text("Actividades"),
                Container(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: controller.dropdownActivity(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                              child: Text(
                                  'Lo sentimos se ha producido un error.'));
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(child: Text('Cargando datos.'));
                        }
                        if (snapshot.data!.docs.isEmpty) {
                          return const Center(
                              child: Text('Registra sitios turisticos.'));
                        }

                        return MultiSelectDialogField(
                          title: Text("Seleccion multiple"),
                          confirmText: Text("CONFIRMAR"),
                          buttonText: Text("Seleccionar"),
                          items: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            return ListActivitys(data);
                          }).single,
                          listType: MultiSelectListType.LIST,
                          onConfirm: (values) {
                            if (values.isNotEmpty) {
                              print("Actividades lista: " + values.toString());
                              controller.updateActivity(values);
                            } else {
                              print("Sin actividad");
                            }
                          },
                          initialValue: [],
                        );
                      }),
                ),
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
                CustomTextFormField(
                    icon: const Icon(BootstrapIcons.facebook),
                    obscureText: false,
                    textGuide: "Facebook del sitio",
                    msgError: "",
                    textInputType: TextInputType.text,
                    fillColor: AppBasicColors.colorTextFormField,
                    controller: controller.facebookTextController),
                SizedBox(height: 15),
                Row(
                  children: [
                    Obx(() => Text(controller.ubicacion.value)),
                    TextButton.icon(
                        onPressed: () {
                          Get.to(() => MapGeolocation());
                        },
                        icon: Icon(
                          Icons.location_on,
                          color: Colors.green,
                        ),
                        label: Text(
                          "Ubicar",
                          style: TextStyle(color: Colors.green),
                        ))
                  ],
                ),
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
                          onPressed: () => Get.to(() => ImageUpload()),
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
                        if (controllerTurismo.imageFileList.isNotEmpty) {
                          controller.validateForms();
                        } else {
                          print("Agregar fotos ");
                        }
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

  List<MultiSelectItem<dynamic>> ListActivitys(Map<String, dynamic> data) {
    List<MultiSelectItem<dynamic>> menuItems = [];
    for (String actividad in data['activity']) {
      menuItems.add(MultiSelectItem<dynamic>(actividad, actividad));
    }
    return menuItems;
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
        controller.tipoTurismo.text = value!;
      },
      hint: Text(hintextValue, style: TextStyle(color: Colors.black26)),
    );
  }

  selectMultPhoto() async {
    try {
      controllerTurismo.imageFileList.clear();
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
    List<XFile> listPhotos = controllerTurismo.imageFileList;
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
            //var myImage = image.image;
            /*if (myImage.width.toDouble() >= 1024 &&
                myImage.width.toDouble() <= 1080) {
              if (myImage.height.toDouble() >= 566 &&
                  myImage.height.toDouble() <= 1080) {
                controller.addFilesImage(element);
              } else {
                photos.remove(element);
              }
            } else {
              photos.remove(element);
            }*/
            controllerTurismo.addFilesImage(element);
          },
        ),
      );
    });

    print("Fotos seleccionadas y validadas.");
  }
}
