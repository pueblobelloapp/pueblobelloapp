import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Controller/GextControllers/GetxSitioTuristico.dart';

class MapGeolocation extends GetView<GetxSitioTuristico> {

  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ubicación sitio'),
      ),
      body: Stack(
        children: [
          GetBuilder<GetxSitioTuristico>(builder: (controller) {
            return GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(10.422522, -73.578462),
                  zoom: 15.0,
                ),
                myLocationEnabled: true,
                onTap: (LatLng latLng) {
                  controller.updatePosition(latLng);
                },
                markers: {
                  Marker(
                      markerId: MarkerId('Sitio'),
                      position: controller.selectedLatLng)
                },
                mapType: MapType.normal);
          })
        ],
      ),
    );
  }
}
