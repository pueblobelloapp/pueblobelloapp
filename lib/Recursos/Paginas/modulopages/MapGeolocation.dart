import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:app_settings/app_settings.dart';

import '../../Controller/GextControllers/GetxSitioTuristico.dart';

class MapGeolocation extends GetView<GetxSitioTuristico> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    checkLocationPermission(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Ubicación sitio'),
      ),
      body: GetBuilder<GetxSitioTuristico>(builder: (controller) {
            return GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(10.422522, -73.578462),
                  zoom: 15.0,
                ),
                myLocationEnabled: true,
                onTap: (LatLng latLng) {
                  controller.updatePosition(latLng);
                },
                markers: {Marker(markerId: MarkerId('Sitio'), position: controller.selectedLatLng)},
                mapType: MapType.normal);
          })
    );
  }

  void checkLocationPermission(BuildContext context) async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.always ||
          permission == LocationPermission.deniedForever ||
          permission == LocationPermission.unableToDetermine) {
        showInformation(context);
      } else {
        showInformation(context);
      }
    }
    controller.update();
  }

  Widget showInformation(BuildContext context) {
    return AlertDialog(
      title: Text('Permiso de Ubicación'),
      content: Text('Para utilizar esta función, necesitas habilitar el permiso de ubicación '
          'en la configuración de tu dispositivo.'),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            AppSettings.openAppSettings();
          },
          child: Text('Aceptar'),
        ),
      ],
    );
  }
}
