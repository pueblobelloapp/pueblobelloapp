import 'dart:io';

import 'package:app_turismo/Recursos/Controller/GextControllers/GetxInformationMunicipio.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GetxSitioTuristico.dart';
import 'package:app_turismo/Recursos/Models/InfoMunicipio.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/ImageUpload.dart';
import 'package:app_turismo/Recursos/Widgets/custom_TextFormField.dart';
import 'package:app_turismo/Recursos/theme/app_theme.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                  onPressed: () {
                    InfoMunicipio infoMunicipio = InfoMunicipio(
                        nombre: controller.tituloControl.text,
                        descripcion: controller.descriptionControl.text,
                        subTitulos: controller.listSubInformation,
                        photos: controller.listPhotosInfo,
                        subCategoria: controller.tipoGestion.toString());

                    if (controller.isLoading.value == true) {
                      if (controller.isSaveOrUpdate.isTrue) {
                        infoMunicipio.id = controller.infoMunicipioUpdate.id;
                        controller.updateMunicipioInformation(controller.indexUpdate);
                      } else {
                        infoMunicipio.id = controller.uidGenerate();
                        controller.saveInformation(infoMunicipio);
                      }
                    } else {
                      messageController.messageError(
                          "Informativo", "Verifica tu red movil.");
                    }
                  },
                  child: Obx(() => controller.isLoading.value == true
                      ? Text(
                          controller.buttonTextSave.value,
                          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LoadingAnimationWidget.discreteCircle(
                                color: Colors.white,
                                size: 15,
                                secondRingColor: Colors.green,
                                thirdRingColor: Colors.white),
                            SizedBox(
                              width: 10,
                            ),
                            Text(controller.buttonTextSave.value,
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))
                          ],
                        ))))),
      SizedBox(width: 15),
      Expanded(
        child: SizedBox(
          height: 50.0,
           child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
              onPressed: () {
                //Aca debe volver a la pagina anterior.
                controller.updateButtonAddSubInfo("Agregar informacion", true);
                controller.cleanSubInfo();
                controller.update();
                Get.back();
              },
            child: Text("Cancelar", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))),
      ))
    ]);
  }

  Widget formInformationGeneral() {
    return Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => mainPhotos()),
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
            key: controller.formKeySub,
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
                      visible: !controller.isSaveOrUpdate.value,
                      child: IconButton(
                        onPressed: () {
                          if (controller.formKeySub.currentState!.validate()) {
                            controller.addSubinformation();
                            messageController.messageInfo("Informaticion", "Agregado al sistema");
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
                Obx(() => mainSubPhotos()),
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

  Widget mainPhotos() {
    List<Widget> listWidget = listPhotosWidget();

    return GestureDetector(
        onTap: () async {
          await Get.to(() => ImageUpload());
          if (sitioController.listCroppedFile.length > 0) {
            controller.listPhotosInfo.clear();
            controller.addPhotosGeneral(sitioController.listCroppedFile);
          }
          controller.update();
        },
        child: containerPhoto(listWidget));
  }

  Widget mainSubPhotos() {
    List<Widget> listSubWidget = listPhotosSubWidget();

    return GestureDetector(
        onTap: () async {
          await Get.to(() => ImageUpload());
          if (sitioController.listCroppedFile.length > 0) {
            controller.listPhotosSubInfo.clear();
            controller.addPhotosSub(sitioController.listCroppedFile);
          }
          print("entra al nada");
          controller.update();
        },
        child: containerPhoto(listSubWidget));
  }

  List<Widget> listPhotosWidget() {
    final List<Widget> photoWidgets = [];
    print("Entra al listPhotosWidget");
    for (final url in controller.listPhotosUrls) {
      print("for11111  listPhotosWidget");
      photoWidgets.add(
        Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            controller.listPhotosUrls.remove(url);
          },
          child: Image.network(url),
        ),
      );
    }

    for (final croppedFile in controller.listPhotosInfo) {
      print("for listPhotosWidget");
      photoWidgets.add(
        Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            controller.listPhotosInfo.remove(croppedFile);
          },
          child: Image.file(File(croppedFile.path)),
        ),
      );
    }
    sitioController.listCroppedFile.clear();

    return photoWidgets;
  }

  List<Widget> listPhotosSubWidget() {
    print("Lista de fotografias");
    final List<Widget> photoSubWidgets = [];

    if (controller.listPhotosSubUrls.isNotEmpty) {
      for (final url in controller.listPhotosSubUrls) {
        photoSubWidgets.add(
          Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              controller.listPhotosSubUrls.remove(url);
            },
            child: Image.network(url),
          ),
        );
      }
    }

    if (controller.listPhotosSubInfo.isNotEmpty) {
      for (final croppedFile in controller.listPhotosSubInfo) {
        photoSubWidgets.add(
          Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              controller.listPhotosSubInfo.remove(croppedFile);
            },
            child: Image.file(File(croppedFile.path)),
          ),
        );
      }
    }
    sitioController.listCroppedFile.clear();
    return photoSubWidgets;
  }

  Widget containerPhoto(List<Widget> listPhotos) {
    print("LLega");
    return Container(
        width: double.infinity,
        height: 350,
        decoration: BoxDecoration(
            color: AppBasicColors.transparent, borderRadius: BorderRadius.circular(10.0)),
        child: Center(
            child: listPhotos.length > 0
                ? carruselPhotos(listPhotos)
                : const Icon(
                    BootstrapIcons.image_alt,
                    size: 100,
                    color: Colors.green,
                  )));
  }

  Widget? carruselPhotos(List<Widget> listPhotos) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 400,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayAnimationDuration: Duration(milliseconds: 1200),
        viewportFraction: 1.3,
        enlargeCenterPage: false,
      ),
      items: listPhotos.map((image) {
        //final path = image.path;
        return Builder(
          builder: (BuildContext context) {
            return ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                  maxHeight: MediaQuery.of(context).size.height,
                ),
                child: image);
          },
        );
      }).toList(),
    );
  }
}
