import 'dart:io';

import 'package:app_turismo/Recursos/Controller/GextControllers/GetxInformationMunicipio.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/ImageUpload.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';

import '../Constants/Constans.dart';
import '../Controller/GextControllers/GextUtils.dart';

class CarouselPhotos extends GetView<GetxInformationMunicipio> {
  final ImageUpload imageUpload = Get.put(ImageUpload());
  final GetxUtils controllerUtils = Get.put(GetxUtils());

  @override
  Widget build(BuildContext context) {
    return Obx(() => validPhotos());
  }

  Widget validPhotos() {
    controller.listWidget = loadPhotosUrlsFirebase(controller.listUrlPhotosFirebase);
    controller.listWidget.addAll(listPhotosWidget());

    print("Con datos");
    return GestureDetector(
        onTap: () async {
          await Get.to(ImageUpload());
        },
        child: controller.listWidget.length > 0
            ? carouselPhotos(controller.listWidget)
            : controllerUtils.imageInformation(Constants.addImage, Constants.addImageDescription));
  }

  List<Widget> loadPhotosUrlsFirebase(List<dynamic> valueList) {
    List<Widget> resultList = [];

    valueList.forEach((dynamic element) {
      resultList.add(Stack(
        children: [
          CachedNetworkImage(
            imageUrl: element,
            progressIndicatorBuilder: (context, url, progress) => Center(
              child: CircularProgressIndicator(
                color: Colors.green,
                value: progress.progress,
              ),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Positioned(
            top: 5,
            right: 10,
            child: FloatingActionButton.small(
              backgroundColor: Colors.red,
              onPressed: () {
                Get.defaultDialog(
                  title: "Fotografia",
                  titleStyle: TextStyle(fontSize: 20),
                  middleText: "Seguro de eliminar la fotografia ?",
                  middleTextStyle: TextStyle(fontSize: 15),
                  backgroundColor: Colors.white,
                  textCancel: "Cancelar",
                  cancelTextColor: Colors.green,
                  textConfirm: "Si",
                  confirmTextColor: Colors.red,
                  onCancel: () {},
                  onConfirm: () {
                    print("element: $element");
                    /*controller.deleteInformation(
                        controller.infoMunicipioUpdate.id,
                        controller.indexUpdate,
                        element);*/
                  },
                  buttonColor: Colors.white,
                );
              },
              child: Icon(Icons.delete),
            ),
          ),
        ],
      ));
    });
    return resultList;
  }

  List<Widget> listPhotosWidget() {
    final List<Widget> photoWidgets = [];
    controller.listCroppedFile
        .asMap()
        .entries
        .map((entry) {
      final index = entry.key;
      final element = entry.value;
      if (element is CroppedFile) {
        photoWidgets.add(Stack(
          children: [
            Image.file(File(element.path)),
            Positioned(
              top: 5,
              right: 10,
              child: FloatingActionButton.small(
                backgroundColor: Colors.red,
                onPressed: () {/*controller.listCroppedFile.removeAt(index);*/
                  Get.defaultDialog(
                    title: "Fotografia",
                    titleStyle: TextStyle(fontSize: 20),
                    middleText: "Seguro de eliminar la fotografia ?",
                    middleTextStyle: TextStyle(fontSize: 15),
                    backgroundColor: Colors.white,
                    textCancel: "Cancelar",
                    cancelTextColor: Colors.green,
                    textConfirm: "Si",
                    confirmTextColor: Colors.red,
                    onCancel: () {},
                    onConfirm: () {
                      controller.listCroppedFile.removeAt(index);
                      controller.update();
                      Get.back();
                    },
                    buttonColor: Colors.white,
                  );
                  },
                child: Icon(Icons.delete),
              ),
            ),
          ],
        ));
      } else {
        controllerUtils.messageWarning("Informacion", "Error al cargar fotografías.");
      }
    }).whereType<CroppedFile>().toList();

    return photoWidgets;
  }

  Widget? carouselPhotos(List<Widget> listPhotos) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 250,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 2000),
        viewportFraction: 1.9,
        enlargeCenterPage: false,
      ),
      items: listPhotos.asMap().entries.map((entry) {
        final index = entry.key;
        final photo = entry.value;
        return Builder(
          builder: (BuildContext context) {
            return ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                  maxHeight: MediaQuery.of(context).size.height,
                ),
                child: photo);
          },
        );
      }).toList(),
    );
  }
}
