import 'package:app_turismo/Recursos/Constants/Constans.dart';
import 'package:app_turismo/Recursos/Controller/GestionController.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GetxGestionInformacion.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GexTurismo.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ListInformationGestion extends StatelessWidget {
  ListInformationGestion({Key? key}) : super(key: key);
  final GextControllerTurismo controllerTurismo =
      Get.put(GextControllerTurismo());

  final EditGestionController editGestionController =
      Get.put(EditGestionController());
  final GetxGestionInformacionController controllerGestion =
      Get.put(GetxGestionInformacionController());

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _informationStream = FirebaseFirestore.instance
        .collection('${controllerTurismo.typeInformation}')
        .snapshots();

    return Container(
        color: Colors.grey.shade200,
        child: SafeArea(
            child: StreamBuilder<QuerySnapshot>(
                stream: _informationStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
                          .cast());
                })));
  }

  Widget listaPropietarioCard(Map<String, dynamic> data) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.fromLTRB(13, 15, 13, 5),
      elevation: 5,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: TextButton.icon(
                onPressed: () {
                  final GextControllerTurismo controllerTurismo =
                      Get.put(GextControllerTurismo());
                  controllerGestion.updateGestionInformacion(
                      data['id'],
                      data['nombre'],
                      data['descripcion'],
                      data['foto'],
                      data['ubicacion'],
                      'Actualizaar');
                  controllerTurismo.updateTapItem(1);
                },
                icon: FaIcon(
                  FontAwesomeIcons.pencil,
                  color: Colors.green,
                ),
                label: Text("")),
            title: Text(data['nombre']),
            trailing: TextButton.icon(
                onPressed: () {},
                icon: FaIcon(FontAwesomeIcons.trash, color: Colors.red),
                label: Text("")),
          ),
        ],
      ),
    );
  }

  void closeSesion(BuildContext context, String uid) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Cerrar sesion"),
              content: const Text("Quieres cerrar sesion ?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('No'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    //Accion para borrar.
                    editGestionController.deleteInformation(
                        uid, controllerTurismo.typeInformation);
                  },
                  child: const Text('Si'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ));
  }
}
