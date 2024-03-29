import 'dart:io';

import 'package:app_turismo/Recursos/Controller/GextControllers/GetxInformationMunicipio.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({
    Key? key,
  }) : super(key: key);

  @override
  _ImageUpload createState() => _ImageUpload();
}

class _ImageUpload extends State<ImageUpload> {
  final GetxInformationMunicipio municipalityController = Get.put(GetxInformationMunicipio());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Fotografias sitio turistico")),
        body: bodyImage(),
        floatingActionButton: municipalityController.listCroppedFile.length == 0 ?
          Container() : FloatingActionButton.small(
            child: Icon(Icons.add_a_photo_sharp),
            backgroundColor: Colors.green,
            onPressed: () {
              _uploadImage();
              setState(() {});
            }),
    );
  }

  Widget bodyImage() {
    if (municipalityController.listCroppedFile.length > 0) {
      return _imageList();
    } else {
      return _uploaderCard();
    }
  }

  Widget _imageList() {
    return ListView.builder(
        itemCount: municipalityController.listCroppedFile.length,
        itemBuilder: (context, int index) {
          return cardImage(municipalityController.listCroppedFile[index], index);
        });
  }

  Widget cardImage(CroppedFile croppedFile, int indexCropped) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Card(
              elevation: 4.0,
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      image(croppedFile),
                      optionImage(indexCropped),
                    ],
                  )),
            ),
          ),
          const SizedBox(height: 5.0),
        ],
      ),
    );
  }

  Widget image(CroppedFile croppedFile) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    if (croppedFile.path != "") {
      final path = croppedFile.path;
      return ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 0.8 * screenWidth,
            maxHeight: 0.7 * screenHeight,
          ),
          child: Image.file(File(path)));
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget optionImage(int indexCropped) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            municipalityController.listCroppedFile.removeAt(indexCropped);
            setState(() {});
          },
          label: const Text("Eliminar"),
          icon: const Icon(Icons.delete),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        ),
        SizedBox(width: 10),
        ElevatedButton.icon(
          onPressed: () {
            cropImage(indexCropped).then((value) => setState(() {}));
          },
          label: const Text("Recortar"),
          icon: const Icon(Icons.crop),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        ),
      ],
    );
  }

  Widget _uploaderCard() {
    return Center(
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: SizedBox(
          width: 320.0,
          height: 300.0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DottedBorder(
                    radius: const Radius.circular(12.0),
                    borderType: BorderType.RRect,
                    dashPattern: const [8, 4],
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_a_photo_rounded,
                            size: 80.0,
                          ),
                          const SizedBox(height: 24.0),
                          Text('Seleccionar fotografias')
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: ElevatedButton(
                  onPressed: () {
                    _uploadImage();
                    setState(() {});
                  },
                  child: const Text('Cargar fotos'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> cropImage(int croppedIndex) async {
    if (municipalityController.listCroppedFile[croppedIndex].path != "") {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: municipalityController.listCroppedFile[croppedIndex].path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Recortar',
              toolbarColor: Colors.green,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true),
          IOSUiSettings(
            title: 'Recorte de imagen',
          )
        ],
      );
      if (croppedFile != null) {
        setState(() {
          municipalityController.listCroppedFile[croppedIndex] = croppedFile;
        });
      }
    }
  }

  Future<void> _uploadImage() async {
    final List<XFile> pickedFileList = await ImagePicker().pickMultiImage();
    if (pickedFileList.isNotEmpty) {
      for (int i = 0; i < pickedFileList.length; i++) {
        CroppedFile? croppedFile = CroppedFile(pickedFileList[i].path);
        municipalityController.listCroppedFile.add(croppedFile);
      }
      setState(() {});
    }
  }
}
