import 'package:app_turismo/Recursos/Controller/GextControllers/GetxInformationMunicipio.dart';
import 'package:app_turismo/Recursos/Models/SiteTuristico.dart';
import 'package:app_turismo/Recursos/Repository/RepositorySiteTuristico.dart';
import 'package:app_turismo/Recursos/Repository/implementation/RepositorySiteTuristicoImp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListSitesTourist extends StatelessWidget {
  const ListSitesTourist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MySitesRepository mySitesRepository = MyRepositorySiteTuristicoImp();

    return Container(
      color: Colors.grey.shade100,
      child: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
        stream: mySitesRepository.getSitesUid(),
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
      title: Text(data['nombre']),
      subtitle: Text(data['tipoTurismo']),
      trailing: Icon(Icons.arrow_forward_ios_outlined),
      onTap: () {

        siteInformation = SitioTuristico(
            id: data['id'],
            nombre: data['nombre'],
            tipoTurismo: data['tipoTurismo'],
            descripcion: data['descripcion'],
            ubicacion: data['ubicacion'],
            contacto: data['contactos'],
            puntuacion: data['puntuacion'],
            actividades: data['servicios'],
            foto: data['foto'],
            userId: data['userId']);

        print(siteInformation.toString());
        //this.mySitesRepository.updateSitioTuristico(siteInformation!);
      },
    );
  }
}
