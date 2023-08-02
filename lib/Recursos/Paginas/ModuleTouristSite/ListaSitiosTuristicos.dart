import 'package:app_turismo/Recursos/Models/SiteTuristico.dart';
import 'package:app_turismo/Recursos/Paginas/ModuleTouristSite/Getx/GetxSitioTuristico.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GexTurismo.dart';
import 'package:app_turismo/Recursos/Paginas/ModuleTouristSite/Controller/SitesController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListaSitiosTuristicos extends StatelessWidget {
  const ListaSitiosTuristicos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EditSitesController editController = Get.find<EditSitesController>();

    return Container(
      color: Colors.grey.shade100,
      child: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
        stream: editController.getSitesUser(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
                child: Text('Lo sentimos se ha producido un error.'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('Cargando datos.'));
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Registra sitios turisticos.'));
          }

          return ListView(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
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

    return ListTile(
      //leading: Image.network(data['foto']),
      title: Text(data['nombre']),
      subtitle: Text(data['tipoTurismo']),
      trailing: Icon(Icons.arrow_forward_ios_outlined),
      onTap: () {
        final GextControllerTurismo controllerTurismo =
            Get.put(GextControllerTurismo());
        final GetxSitioTuristico _controllerGetxTurismo =
            Get.put(GetxSitioTuristico());

        siteInformation = SitioTuristico(
            id: data['id'],
            nombre: data['nombre'],
            estado: data['estado'],
            tipoTurismo: data['tipoTurismo'],
            descripcion: data['descripcion'],
            ubicacion: data['ubicacion'],
            contacto: data['contactos'],
            horarios: data['horario'],
            puntuacion: data['puntuacion'],
            servicios: data['servicios'],
            direccion: data['direccion'],
            foto: data['foto'],
            userId: data['userId']);

        print(siteInformation.toString());
        _controllerGetxTurismo.updateSitioTuristico(siteInformation!);
        controllerTurismo.updateTapItem(1);
      },
    );
  }
}