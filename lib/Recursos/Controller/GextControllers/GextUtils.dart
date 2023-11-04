import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'GetxConnectivity.dart';

class GetxUtils extends GetxController {
  bool _isReadyAction = true;
  bool get isReadyAction => _isReadyAction;
  final ConnectivityController connectivityController = Get.put(ConnectivityController());

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
        icon: Icon(Icons.info_outline, color: Colors.white)));
  }

  void messageError(String titulo, String mensaje) {
    Get.showSnackbar(GetSnackBar(
        title: titulo,
        message: mensaje,
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red.shade600,
        reverseAnimationCurve: Curves.easeOutSine,
        forwardAnimationCurve: Curves.easeOutSine,
        margin: const EdgeInsets.all(10.0),
        icon: Icon(
          Icons.error_outline,
          color: Colors.white,
        )));
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
        icon: Icon(Icons.warning_amber, color: Colors.white)));
  }

  Widget imageInformation(String routeImage, String description) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          routeImage, //"assets/img/no-internet.png",
          height: 100,
          width: 100,
        ),
        SizedBox(height: 10),
        Text(description, style: TextStyle(color: Colors.green, fontSize: 25))
      ],
    ));
  }
}
