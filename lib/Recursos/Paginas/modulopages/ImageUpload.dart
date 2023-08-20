import 'dart:io';
import 'package:app_turismo/Recursos/Paginas/ModuleTouristSite/Getx/GetxSitioTuristico.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends GetView<GetxSitioTuristico> {
  var screenWidth;
  var screenHeight;

  @override
  Widget build(BuildContext context) {
   screenWidth = MediaQuery.of(context).size.width;
   screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    if (controller.listCroppedFile.length > 0) {
      print("iF");
      return _imageList();
    } else {
      print("Else");
      return _uploaderCard();
    }
  }

  Widget _imageList() {
    return ListView.builder(
        itemCount: controller.listCroppedFile.length,
        itemBuilder: (context, int index) {
          return cardImage(controller.listCroppedFile[index], index);
        }
    );
  }

  Widget cardImage (CroppedFile _croppedFile, int indexCropped) {
    print("_croppedFile: " + _croppedFile.path);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: image(_croppedFile),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          _menu(indexCropped),
        ],
      ),
    );
  }

  Widget image(CroppedFile croppedFile) {
    if (croppedFile.path != "") {
      final path = croppedFile!.path;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.8 * screenWidth,
          maxHeight: 0.7 * screenHeight,
        ),
        child: Image.file(File(path)),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _menu(int indexCropped) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          onPressed: () {
            controller.listCroppedFile.removeAt(indexCropped);
          },
          backgroundColor: Colors.redAccent,
          tooltip: 'Delete',
          child: const Icon(Icons.delete),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: FloatingActionButton(
            onPressed: () {
              cropImage(indexCropped);
            },
            backgroundColor: const Color(0xFFBC764A),
            tooltip: 'Crop',
            child: const Icon(Icons.crop),
          ),
        )
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
                            Icons.image,
                            size: 80.0,
                          ),
                          const SizedBox(height: 24.0),
                          Text('Upload an image to start')
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
                  },
                  child: const Text('Upload'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> cropImage(int croppedIndex) async {
    if (controller.listCroppedFile[croppedIndex].path != "") {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: controller.listCroppedFile[croppedIndex].path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        maxHeight: 1080,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          )
        ],
      );
      if (croppedFile != null) {
        controller.listCroppedFile[croppedIndex] = croppedFile;
      }
    }
  }

  Future<void> _uploadImage() async {
    final List<XFile> pickedFileList = await ImagePicker().pickMultiImage();
    if (pickedFileList != null) {
      print("Setea fotos");

      for (int i = 0; i < pickedFileList.length; i++) {
        CroppedFile? croppedFile = CroppedFile(pickedFileList[i].path);
        controller.listCroppedFile.add(croppedFile);
      }
    } else {
      print("Sin datos");
    }
  }

  void _clear(int index) {
    print("Longigtud: ${controller.listCroppedFile.length}");
    if (controller.listCroppedFile.isNotEmpty) {
      controller.listCroppedFile.removeAt(index);
    } else {

    }

      controller.listCroppedFile.clear();
      controller.listPickedFile.clear();
  }
}