import 'package:app_turismo/Recursos/Models/InfoMunicipio.dart';
import 'package:flutter/material.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GetxInformationMunicipio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ListInformationMunicipio extends StatelessWidget {
  ListInformationMunicipio({Key? key}) : super(key: key);

  final GetxInformationMunicipio controllerTurismo = Get.put(GetxInformationMunicipio());

  @override
  Widget build(BuildContext context) {
    List<dynamic> subTitulosList = [];
    final Stream<QuerySnapshot> _informationStream = controllerTurismo.listInfo();
    return Container(
        color: Colors.grey.shade200,
        child: SafeArea(
            child: StreamBuilder<QuerySnapshot>(
                stream: _informationStream,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Lo sentimos se ha producido un error.'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Cargando sub titulos"),
                        LoadingAnimationWidget.discreteCircle(
                            color: Colors.white,
                            size: 50,
                            secondRingColor: Colors.green,
                            thirdRingColor: Colors.white)
                      ],
                    ));
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return Center(
                        child: Text("No tienes sub titulos registrados",
                            style: TextStyle(fontWeight: FontWeight.bold)));
                  }

                  snapshot.data!.docs.forEach((document) {
                    final data = document.data() as Map<String, dynamic>;
                    subTitulosList = data['subTitulos'];
                  });

                  return ListView.builder(
                      itemCount: subTitulosList.length,
                      itemBuilder: (context, index) {
                        SubTitulo subTitulo = SubTitulo.fromFirebaseMap(subTitulosList[index]);
                        return Card(
                          elevation: 3.5,
                          margin: const EdgeInsets.fromLTRB(25, 25, 25, 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(subTitulo.titulo),
                                trailing: IconButton(
                                  icon: FaIcon(FontAwesomeIcons.pen,
                                      color: Colors.green), // Reemplaza 'your_icon' con el icono que desees
                                  onPressed: () {
                                    // Agrega la lógica que deseas ejecutar cuando se presiona el botón.
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                })));
  }
}
