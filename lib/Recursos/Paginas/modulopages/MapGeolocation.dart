import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../ModuleTouristSite/GetxSitioTuristico.dart';

class MapGeolocation extends GetView<GetxSitioTuristico> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ubicacion sitio'),
      ),
      body: Stack(
        children: [
          GetBuilder<GetxSitioTuristico>(builder: (controller) {
            return GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target:
                      LatLng(10.422522, -73.578462),
                  zoom: 15.0,
                ),
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
