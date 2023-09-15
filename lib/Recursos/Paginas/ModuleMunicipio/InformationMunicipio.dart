import 'dart:io';

import 'package:app_turismo/Recursos/Controller/GextControllers/GetxInformationMunicipio.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GetxSitioTuristico.dart';
import 'package:app_turismo/Recursos/Models/InfoMunicipio.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/ImageUpload.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/MapGeolocation.dart';
import 'package:app_turismo/Recursos/Widgets/custom_TextFormField.dart';
import 'package:app_turismo/Recursos/theme/app_theme.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:webviewx/webviewx.dart';

class InformationMunicipio extends GetView<GetxInformationMunicipio> {
  final GetxSitioTuristico sitioController = Get.put(GetxSitioTuristico());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      reverse: true,
      child: FormData(),
    );
  }

  Widget FormData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        formInformationGeneral(),
        formSubInformation(),
        SizedBox(height: 10),
        buttonSaveInformation()
      ],
    );
  }

  Widget buttonSaveInformation() {
    return SizedBox(
        width: double.infinity,
        height: 50.0,
        child: ElevatedButton(
            onPressed: () {
              if (controller.formKey.currentState!.validate()) {
                InfoMunicipio infoMunicipio = InfoMunicipio(
                    nombre: controller.tituloControl.text,
                    descripcion: controller.descriptionControl.text,
                    subTitulos: controller.listSubInformation,
                    ubicacion: sitioController.mapUbications,
                    photos: controller.listPhotosInfo,
                    subCategoria: controller.tipoGestion.toString(),
                    id: controller.uidGenerate());

                //todo: Is true save
                if (controller.isSaveOrUpdate.value) {
                  controller.saveGestion(infoMunicipio);
                } else {
                  controller.updateGestion(infoMunicipio);
                }
              }
            },
            child: Obx(() => controller.isLoading.value == false
                ? Text(
                    controller.buttonTextSave.value,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoadingAnimationWidget.discreteCircle(
                          color: Colors.white,
                          size: 20,
                          secondRingColor: Colors.green,
                          thirdRingColor: Colors.white),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Guardando",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold))
                    ],
                  ))));
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
            SizedBox(height: 10),
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
                    icon:
                        Icon(BootstrapIcons.pin_map_fill, color: Colors.white),
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
            SizedBox(height: 15)
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
                    Text(
                      'Información adicional',
                      style: TextStyle(
                          color: AppBasicColors.green, fontSize: 16.0),
                    ),
                    IconButton(
                        onPressed: () {
                          //Logica para agregar sub iformacion.
                          if (controller.formKeySub.currentState!.validate()) {
                            controller.addSubinformation();
                          }
                        },
                        icon: Icon(
                          BootstrapIcons.plus_square_fill,
                          size: 30.0,
                          color: AppBasicColors.green,
                        ))
                  ],
                ),
                //_containerPhoto(imageLocation: "subtitulo"),
                SizedBox(height: 10),
                Text(
                  'Subtítulo',
                  style: TextStyle(
                      color: AppBasicColors.green,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
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
                Text(
                  'Descripción',
                  style: TextStyle(
                      color: AppBasicColors.green,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
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
                    maxLinesText: 6)
              ],
            ),
          )),
    );
  }

  Widget mainPhotos() {
    print("Mainphotos");
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

  List<Widget> listPhotosWidget() {
    final List<Widget> photoWidgets = [];

    for (final url in controller.listPhotosUrls) {
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

    return photoWidgets;
  }

  Widget containerPhoto(List<Widget> listPhotos) {
    return Container(
        width: double.infinity,
        height: 350,
        decoration: BoxDecoration(
            color: AppBasicColors.transparent,
            borderRadius: BorderRadius.circular(10.0)),
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
        height: 400, // Altura del carrusel
        enableInfiniteScroll: true, // Habilitar desplazamiento infinito
        autoPlay: true, // Reproducción automática
        autoPlayAnimationDuration:
            Duration(milliseconds: 1200), // Duración de la animación
        viewportFraction:
            1.3, // Porcentaje del ancho de la pantalla para mostrar
        enlargeCenterPage: false, // Enfocar la imagen en el centro
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
