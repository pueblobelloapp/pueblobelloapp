import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PhotoLoad extends GetxController {
  var selectedPhoto = XFile('').obs;

  // Método para seleccionar una foto galeria
  void selectPhoto() async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      selectedPhoto.value = pickedImage;
      update();
    }
  }

  // Método para capturar fotografia.
  void takePhoto() async {
    final imagePicker = ImagePicker();
    final XFile? takenImage =
        await imagePicker.pickImage(source: ImageSource.camera);

    if (takenImage != null) {
      selectedPhoto.value = takenImage;
      update();
    }
  }
}
