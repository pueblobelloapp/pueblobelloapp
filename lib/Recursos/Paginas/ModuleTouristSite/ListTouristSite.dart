import 'package:app_turismo/Recursos/Controller/GextControllers/GetxConnectivity.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GetxInformationMunicipio.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GetxManagementTouristSite.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GextUtils.dart';
import 'package:app_turismo/Recursos/Models/SiteTuristico.dart';
import 'package:app_turismo/Recursos/Paginas/ModuleTouristSite/RegisterTouristSite.dart';
import 'package:app_turismo/Recursos/Repository/RepositorySiteTuristico.dart';
import 'package:app_turismo/Recursos/Repository/implementation/RepositorySiteTuristicoImp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../Models/InfoMunicipio.dart';

class ListSitesTourist extends GetView<GetxManagementTouristSite> {
  final ConnectivityController connectivityController = Get.put(ConnectivityController());
  final GetxUtils controllerUtils = Get.put(GetxUtils());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Información"),
        actions: [
          TextButton(
            child: Text(
              "Añadir sitios",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              if (!controller.infoExists.value && !connectivityController.isOnline.value) {
                controllerUtils.messageWarning("Infromacion", "Ups! Sin conexion a internet.");
              } else {
                actionForms();
                Get.to(() => RegisterTouristSite(), transition: Transition.leftToRight);
              }
              controller.update();
            },
          )
        ],
      ),
      body: mainList(),
    );
  }

  Widget mainList() {
    bool connectionStatus = false;
    final MySitesRepository mySitesRepository = MyRepositorySiteTuristicoImp();
    return Container(
      color: Colors.grey.shade100,
      child: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
        stream: mySitesRepository.getSitesUid(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Lo sentimos se ha producido un error.'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('Cargando datos.'));
          }

          if (snapshot.data!.docs.isEmpty) {
            controller.infoExists.value = false;
            return Center(
              child: Container(
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Image(
                    image: AssetImage('assets/img/cloud.png'),
                    width: 100,
                    height: 100,
                  ),
                  TextButton(
                    onPressed: () {
                      controller.titleAppbar.value = "Agregar Titulo";
                      Get.to(() => RegisterTouristSite(), transition: Transition.leftToRight);
                    },
                    child: Text("Registrar Informacion",
                        style: TextStyle(color: Colors.green, fontSize: 15)),
                  )
                ]),
              ),
            );
          } else if (connectionStatus == true) {
            controller.infoExists.value = true;
          }

          return ListView(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  return listaSitios(data);
                })
                .toList()
                .cast(),
          );
        },
      )),
    );
  }

  Widget listaSitios(Map<String, dynamic> data) {
    SitioTuristico? siteInformation;
    String puntuacion = "0";
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      margin: EdgeInsets.all(5),
      elevation: 3,
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            title: Text(
              data['nombre'],
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            subtitle: Text("Tipo turismo: " + data['tipoTurismo']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star, color: Colors.yellow, size: 35.0),
                Text(totalPuntuacion(data["puntuacion"]))
              ],
            ),
            leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: new BoxDecoration(
                  border: new Border(right: new BorderSide(width: 1.5, color: Colors.grey))),
              child: Icon(Icons.house_sharp, color: Colors.grey, size: 35),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 10),
              buttonUpdate("Eliminar", Colors.red, data),
              SizedBox(width: 10),
              buttonUpdate("Actualizar", Colors.green, data)
            ],
          )
        ],
      ),
    );
  }

  String totalPuntuacion(List<dynamic> puntuaciones) {
    int suma = 0;

    for (var mapa in puntuaciones) {
      int puntuacion = mapa['calificacion'];
      suma = puntuacion + suma;
    }

    return suma.toString();
  }

  void actionForms() {
    controller.cleanForm();
    controller.listActivitys.clear();
    controller.titleAppbar.value = "Agregar Subtitulo";
    controller.buttonTextSave.value = "Agregar";
  }

  Widget buttonUpdate(String action, Color color, Map<String, dynamic> data) {
    return TextButton(
      style: TextButton.styleFrom(
          foregroundColor: color, textStyle: TextStyle(fontWeight: FontWeight.bold)),
      onPressed: () {
        if (action == "Actualizar") {
          //Actualizamos y llamamos la otra vista mandar valores por getx
          controller.siteInformation = SitioTuristico(
              id: data['id'],
              nombre: data['nombre'],
              tipoTurismo: data['tipoTurismo'],
              descripcion: data['descripcion'],
              ubicacion: Ubicacion.fromFirebaseMap(data['ubicacion']),
              contacto: data['contacto'],
              actividades: data['actividades'],
              foto: data['foto'],
              userId: data['userId']);

          controller.titleAppbar.value = "Actualizar Sitio";
          controller.setDataToForm();
          print("Sitio: " + controller.siteInformation.ubicacion!.lat.toString());
          Get.to(() => RegisterTouristSite());
        } else {
          //Eliminamos pregunta si va eliminar y mandar a borrar si es true.
        }
      },
      child: Text(action),
    );
  }
}
