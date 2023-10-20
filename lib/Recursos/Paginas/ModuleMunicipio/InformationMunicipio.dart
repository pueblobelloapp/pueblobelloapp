import 'dart:io';

import 'package:app_turismo/Recursos/Controller/GextControllers/GetxInformationMunicipio.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GetxSitioTuristico.dart';
import 'package:app_turismo/Recursos/Models/InfoMunicipio.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/ImageUpload.dart';
import 'package:app_turismo/Recursos/Widgets/custom_TextFormField.dart';
import 'package:app_turismo/Recursos/theme/app_theme.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../Controller/GextControllers/GextUtils.dart';

class InformationMunicipio extends GetView<GetxInformationMunicipio> {
  final GetxSitioTuristico sitioController = Get.put(GetxSitioTuristico());
  final GetxUtils messageController = Get.put(GetxUtils());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Formulario")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        reverse: true,
        child: Obx(() => FormData()),
      ),
    );
  }

  Widget FormData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Visibility(child: formInformationGeneral(), visible: controller.infoMainVisible.value),
        Visibility(child: formSubInformation(), visible: controller.infoSubVisible.value),
        SizedBox(height: 15),
        buttonUpdate()
      ],
    );
  }

  Widget buttonUpdate() {
    return Row(children: [
      Expanded(
          child: SizedBox(
              height: 50.0,
              child: ElevatedButton(
                  onPressed: () async {
                    bool validation = false;

                    if (controller.infoSubVisible == true) {
                      if (controller.keyTitleSub.currentState!.validate()) {
                        validation = true;
                      }
                    } else if ( controller.infoMainVisible == true) {
                      if (controller.keyTitleMain.currentState!.validate()) {
                        validation = true;
                      }
                    }

                    if (validation) {
                      await controller.updateActionButton().then((value) {
                        Get.back();
                      }).onError((error, stackTrace) {
                        messageController.messageError("Error", "Error inesperado: ${error}");
                      });
                    }
                  },
                  child: Obx(() => Text(
                          controller.buttonTextSave.value,
                          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                        ))))),
      SizedBox(width: 15),
      Expanded(
          child: SizedBox(
            height: 50.0,
            child: ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
                onPressed: () {
                  //Aca debe volver a la pagina anterior.
                  controller.updateButtonAddSubInfo("Agregar informacion");
                  controller.cleanForm();
                  controller.update();
                  Get.back();
                },
                child: Text("Cancelar", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))),
      ))
    ]);
  }

  Widget formInformationGeneral() {
    return Form(
        key: controller.keyTitleMain,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => photosView(controller.listPhotosInfo, "title")),
            SizedBox(height: 15),
            Text(
              'Título informativo',
              style: TextStyle(color: AppBasicColors.green, fontSize: 16.0),
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
            Text(
              'Descripción informativa',
              style: TextStyle(color: AppBasicColors.green, fontSize: 16.0),
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
            SizedBox(height: 20)
          ],
        ));
  }

  Widget formSubInformation() {
    return Container(
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
          child: Form(
            key: controller.keyTitleSub,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => Text(
                          controller.subInfoAdd.value,
                          style: TextStyle(color: AppBasicColors.green, fontSize: 16.0),
                        )),
                    Visibility(
                      visible: controller.isSaveInformation.isTrue,
                      child: IconButton(
                        onPressed: () {
                          if (controller.keyTitleSub.currentState!.validate()) {
                            controller.addSubinformation();
                            messageController.messageInfo("Informaticion", "Agregado a la lista.");
                          }
                        },
                        icon: Icon(
                          BootstrapIcons.plus_square_fill,
                          size: 30.0,
                          color: AppBasicColors.green,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Obx(() => photosView(controller.listPhotosInfo, "subtitle")),
                SizedBox(height: 10),
                Text(
                  'Subtítulo',
                  style: TextStyle(
                      color: AppBasicColors.green, fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 3),
                CustomTextFormField(
                    obscureText: false,
                    textGuide: "Título",
                    msgError: "Campo obligatorio.",
                    textInputType: TextInputType.text,
                    fillColor: AppBasicColors.white,
                    controller: controller.subTituloControl,
                    valueFocus: false),
                SizedBox(height: 10),
                Text(
                  'Descripción',
                  style: TextStyle(
                      color: AppBasicColors.green, fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 3),
                CustomTextFormField(
                    obscureText: false,
                    textGuide: "Ingrese la descripción",
                    msgError: "Campo obligatorio.",
                    textInputType: TextInputType.text,
                    fillColor: AppBasicColors.white,
                    controller: controller.subDescriptionControl,
                    valueFocus: false,
                    maxLinesText: 6)
              ],
            ),
          )),
    );
  }

  Widget photosView(List<CroppedFile> listPhotos, String section) {
    List<Widget> listWidget = [];

    if (section == "title") {
      listWidget = listPhotosWidget();
    } else {
      listWidget = listPhotosSubWidget();
    }

    return GestureDetector(
        onTap: () async {
          await Get.to(() => ImageUpload());
          if (sitioController.listCroppedFile.length > 0) {
            listPhotos.clear();
            if (section == "title") {
              controller.addPhotosGeneral(sitioController.listCroppedFile);
            } else {
              controller.addPhotosSub(sitioController.listCroppedFile);
            }
          }
          controller.update();
        },
        child: carruselPhotos(listWidget));
  }

  List<Widget> listPhotosWidget() {
    final List<Widget> photoWidgets = [];

    if (controller.listPhotosUrls.isNotEmpty) {
      for (final path in controller.listPhotosUrls) {
        photoWidgets.add(CachedNetworkImage(
          imageUrl: path,
          progressIndicatorBuilder: (context, url, progress) => Center(
            child: CircularProgressIndicator(
              color: Colors.green,
              value: progress.progress,
            ),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ));
      }
    }

    if (controller.listPhotosInfo.isNotEmpty) {
      for (final croppedFile in controller.listPhotosInfo) {
        photoWidgets.add(Image.file(File(croppedFile.path)));
      }
    }
    sitioController.listCroppedFile.clear();

    return photoWidgets;
  }

  List<Widget> listPhotosSubWidget() {
    final List<Widget> photoSubWidgets = [];

    if (controller.listPhotosSubUrls.isNotEmpty) {
      for (final path in controller.listPhotosSubUrls) {
        photoSubWidgets.add((CachedNetworkImage(
          imageUrl: path,
          progressIndicatorBuilder: (context, url, progress) => Center(
            child: CircularProgressIndicator(
              color: Colors.green,
              value: progress.progress,
            ),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        )));
      }
    }

    if (controller.listPhotosSubInfo.isNotEmpty) {
      print("Recorre imagenes");
      for (final croppedFile in controller.listPhotosSubInfo) {
        photoSubWidgets.add(Image.file(File(croppedFile.path)));
      }
    }

    sitioController.listCroppedFile.clear();
    return photoSubWidgets;
  }

  Widget? carruselPhotos(List<Widget> listPhotos) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 350,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayAnimationDuration: Duration(milliseconds: 2000),
        viewportFraction: 1.9,
        enlargeCenterPage: false,
      ),
      items: listPhotos.map((path) {
        return Builder(
          builder: (BuildContext context) {
            return ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                  maxHeight: MediaQuery.of(context).size.height,
                ),
                child: path);
          },
        );
      }).toList(),
    );
  }
}
