import 'package:app_turismo/Recursos/Models/InfoMunicipio.dart';
import 'package:app_turismo/Recursos/theme/app_theme.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
    late InfoMunicipio infoMunicipio;

    return Scaffold(
      appBar: AppBar(title: const Text("Titulos informativos")),
      body: Container(
          color: Colors.grey.shade200,
          child: SafeArea(
              child: StreamBuilder<QuerySnapshot>(
                  stream: controllerTurismo.listInfo(),
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
                      return Center(
                          child: Text("No tienes sub titulos registrados",
                              style: TextStyle(fontWeight: FontWeight.bold)));
                    }

                    snapshot.data!.docs.forEach((document) {
                      final data = document.data() as Map<String, dynamic>;
                      infoMunicipio = InfoMunicipio.fromFirebaseMap(data);
                    });

                    return ListView(children: listSubinformation(infoMunicipio, context));
                  }))),
    );
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
      ListTile subTitle =
          ListTile(title: Text("Titulo principal"), subtitle: Text(subtitulos.titulo));

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
          if (direction == DismissDirection.startToEnd) {
            return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Actualizar subtitulo"),
                  content: const Text("Quieres actualizar la informacion?"),
                  actions: <Widget>[
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                        ),
                        onPressed: () {
                          //Aca actualizara y redirecciona a la nueva vista.
                          //Agregar mas campo para validar que mostrar que formularios.
                          controllerTurismo.updateInforMunicipio(infoMunicipio, index);
                          Get.toNamed("GestionSites");
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
              },
            );
          } else {
            return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Eliminar subtitulo"),
                  content: const Text("Estas seguro de eliminar la informacion?"),
                  actions: <Widget>[
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                        ),
                        onPressed: () => Navigator.of(context).pop(true), //Aca eliminara
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
              },
            );
          }
        },
        child: listTile);
  }
}
