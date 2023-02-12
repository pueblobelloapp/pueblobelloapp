import 'package:app_turismo/Recursos/Controller/GextControllers/GexTurismo.dart';
import 'package:app_turismo/Recursos/Controller/SitesController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListaSitiosTuristicos extends StatelessWidget {
  const ListaSitiosTuristicos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    //final editController = Get.find<EditSitesController>();
    final EditSitesController editController = Get.find();

    return Container(
      color: Colors.grey.shade100,
      child: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
        stream: editController.getSitesUser(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print("Lo sentimos se ha producido un error.");
            return const Center(
                child: Text('Lo sentimos se ha producido un error.'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("Conexion con los datos");
            return const Center(child: Text('Cargando datos.'));
          }

          if (snapshot.data!.docs.isEmpty) {
            print("Registra datos");
            return const Center(child: Text('Registra sitios turisticos.'));
          }

          print(snapshot.data!.toString());

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
    print("Los datos:" + data.toString() );
    return ListTile(
      leading: Image.network(data['foto']),
      title: Text(data['nombre']),
      subtitle: Text(data['tipoTurismo']),
      trailing: Icon(Icons.arrow_forward_ios_outlined),
      onTap: () {
        final GextControllerTurismo controllerTurismo =
            Get.put(GextControllerTurismo());

        /* final editController = Get.find<EditSitesController>();

        editController.editSite(
            data['id'],
            data['nombre'],
            data['capacidad'],
            data['tipoTurismo'],
            data['descripcion'],
            data['ubicacion'],
            data['userId']);*/

        controllerTurismo.updateTapItem(1);
      },
    );
  }
}
