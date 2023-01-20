import 'package:app_turismo/Recursos/Controller/GextControllers/GetxGestionInformacion.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GexTurismo.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListInformationGestion extends StatelessWidget {
  ListInformationGestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final GextControllerTurismo controllerTurismo =
        Get.put(GextControllerTurismo());

    final GetxGestionInformacionController controllerGestion =
    Get.put(GetxGestionInformacionController());

    final Stream<QuerySnapshot> _informationStream =
    FirebaseFirestore.instance
        .collection('${controllerTurismo.typeInformation}')
        .snapshots();

    return Container(
      color: Colors.grey.shade100,
      child: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
        stream: _informationStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
                child: Text('Lo sentimos se ha producido un error.'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('Cargando datos.'));
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(
                child: Text("Sin datos para mostrar",
                    style: TextStyle(fontWeight: FontWeight.bold)));
          }
          //if(!snapshot.hasData) return CircularProgressIndicator();
          return ListView(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return listaPropietarioCard(data);
                })
                .toList()
                .cast(),
          );
        },
      )),
    );
  }

  Widget listaPropietarioCard(Map<String, dynamic> data) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(17),
      elevation: 5,
      child: Column(
        children: <Widget>[
          ListTile(
              leading: Image.network(data['foto']),
              title: Text(data['nombre']),
              subtitle: Text(data['descripcion'])),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    final GextControllerTurismo controllerTurismo =
                        Get.put(GextControllerTurismo());

                    final editController = Get.find<GetxGestionInformacionController>();

                    editController.updateGestionInformacion(
                        data['id'],
                        data['nombre'],
                        data['descripcion'],
                        data['foto'],
                        data['ubicacion'],
                        'Actualizaar'
                    );

                    controllerTurismo.updateTapItem(1);
                  },
                  child: Text('Actualizar')),
              SizedBox(width: 10),
              ElevatedButton(onPressed: () => {}, child: Text('Borrar')),
              SizedBox(width: 10),
            ],
          )
        ],
      ),
    );
  }
}
