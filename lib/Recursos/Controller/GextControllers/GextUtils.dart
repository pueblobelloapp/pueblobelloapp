import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetxUtils extends GetxController {

  bool _isReadyAction = true;
  bool get isReadyAction => _isReadyAction;

  void updateAction(bool state) {
    print("Actualiza estado");
    _isReadyAction = state;
    update();
  }

  void messageInfo(String titulo, String mensaje) {
    Get.showSnackbar(GetSnackBar(
      title: titulo,
      message: mensaje,
      duration: Duration(seconds: 2),
      backgroundColor: Colors.green.shade600,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.decelerate,
      margin: const EdgeInsets.all(10.0),
      icon: Icon(Icons.info_outline)
    ));
  }

  void messageError(String titulo, String mensaje) {
    Get.showSnackbar(GetSnackBar(
      title: titulo,
      message: mensaje,
      duration: Duration(seconds: 6),
      backgroundColor: Colors.red.shade600,
      reverseAnimationCurve: Curves.easeOutSine,
      forwardAnimationCurve: Curves.easeOutSine,
      margin: const EdgeInsets.all(10.0),
        icon: Icon(Icons.error_outline)
    ));
  }

  void messageWarning(String titulo, String mensaje) {
    Get.showSnackbar(GetSnackBar(
      title: titulo,
      message: mensaje,
      duration: Duration(seconds: 3),
      backgroundColor: Colors.yellow.shade800,
      reverseAnimationCurve: Curves.easeOutSine,
      forwardAnimationCurve: Curves.easeOutSine,
      margin: const EdgeInsets.all(10.0),
        icon: Icon(Icons.warning_amber)
    ));
  }

}