import 'package:app_turismo/Recursos/Models/InfoMunicipio.dart';
import 'package:app_turismo/Recursos/Models/SiteTuristico.dart';
import 'package:app_turismo/Recursos/theme/app_theme.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GetxInformationMunicipio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'InformationMunicipio.dart';

class ListInformationMunicipio extends GetView<GetxInformationMunicipio> {
  @override
  Widget build(BuildContext context) {
    late InfoMunicipio infoMunicipio;

    return Scaffold(
      appBar: AppBar(title: const Text("Titulos informativos")),
      body: informationList(),
      floatingActionButton: !controller.infoExists.value ?
          null : FloatingActionButton.small(
            backgroundColor: Colors.green,
            onPressed: () {print("Agregando mas");},
            child: const Icon(Icons.add),
      ),
    );
  }

  Widget informationList() {
    late InfoMunicipio infoMunicipio;
    return Container(
        color: Colors.grey.shade200,
        child: SafeArea(
            child: StreamBuilder<QuerySnapshot>(
                stream: controller.listInfo(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Lo sentimos se ha producido un error.'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Text("Cargando Datos"),
                          LoadingAnimationWidget.discreteCircle(
                            color: Colors.white,
                            size: 50,
                            secondRingColor: Colors.green,
                            thirdRingColor: Colors.white)
                      ],
                    ));
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    controller.infoExists.value = false;
                    return Center(
                      child: Container(
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          const Image(
                            image: AssetImage('assets/img/cloud.png'),
                            width: 150,
                            height: 150,
                          ),
                          TextButton(
                            onPressed: () {
                              print("Registrar informacion");
                              controller.updateVisibilityForms(true, true);
                              Get.toNamed("GestionSites");
                            },
                            child: Text("Registrar Informacion",
                                style: TextStyle(color: Colors.green, fontSize: 15)),
                          )
                        ]),
                      ),
                    );
                  } else {
                    controller.infoExists.value = true;
                  }

                    snapshot.data!.docs.forEach((document) {
                      final data = document.data() as Map<String, dynamic>;
                      infoMunicipio = InfoMunicipio.fromFirebaseMap(data);
                    });

                    return ListView(
                        scrollDirection: Axis.vertical,
                        children: ListTile.divideTiles(
                          color: Colors.grey,
                          context: context,
                          tiles: listSubinformation(infoMunicipio, context),
                        ).toList());
                  })));
  }

  List<Widget> listSubinformation(InfoMunicipio infoMunicipio, BuildContext context) {
    List<Widget> information = [];
    int index = 0;

    ListTile mainTitle = ListTile(
      title: Text("Titulo principal"),
      subtitle: Text(infoMunicipio.nombre),
    );
    information.add(dismissibleWidGet(context, infoMunicipio, mainTitle, 0));

    for (var subtitulos in infoMunicipio.subTitulos) {
      ListTile subTitle = ListTile(title: Text("Subtitulos"), subtitle: Text(subtitulos.titulo));
      information.add(dismissibleWidGet(context, infoMunicipio, subTitle, index));
      index++;
    }
    return information;
  }

  Widget dismissibleWidGet(
      BuildContext context, InfoMunicipio infoMunicipio, ListTile listTile, int index) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.green,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: const [
                FaIcon(FontAwesomeIcons.pen, color: Colors.white),
                SizedBox(
                  width: 8.0,
                ),
                Text('Actualizar', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
        secondaryBackground: Container(
          color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                FaIcon(FontAwesomeIcons.trash, color: Colors.white),
                SizedBox(
                  width: 8.0,
                ),
                Text('Eliminar', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
        confirmDismiss: (DismissDirection direction) async {
          bool? confirmation = false;
          if (direction == DismissDirection.startToEnd) {
            confirmation = await menssageAlert("Actualizar", infoMunicipio, index, context);
          } else {
            confirmation = await menssageAlert("Eliminar", infoMunicipio, index, context);
          }

          if (confirmation!) {
            print("Actualizar");
          }
        },
        child: listTile);
  }

  Future<bool?> menssageAlert(
      String titulo, InfoMunicipio infoMunicipio, int index, BuildContext context) async {
    String mensage = "";

    //Si es -1 es el titulo principal
    if (index == -1) {
      if (titulo == "Actualizar") {
        mensage = "Actualizar titulo principal?";
      } else {
        mensage = "Se eliminaran todos los datos, estas seguro ?";
      }
    } else {
      //Sino es un subtitulo cual quiera
      mensage = "${titulo} el subtitulo?";
    }

    final bool? confirmation = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(titulo),
            content: Text("Seguro de ${titulo.toLowerCase()} la informacion?"),
            actions: <Widget>[
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    if (titulo == "Actualizar") {
                      controller.updateInforMunicipio(infoMunicipio, index);
                      Get.to(() => InformationMunicipio());
                    } else {
                      print("Borrando informacion");
                    }
                  },
                  child: const Text("Si")),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                ),
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("No"),
              ),
            ],
          );
        });

    return confirmation;
  }
}
