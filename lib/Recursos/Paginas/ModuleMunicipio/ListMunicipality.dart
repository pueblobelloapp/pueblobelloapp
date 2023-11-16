import 'package:app_turismo/Recursos/Controller/GextControllers/GetxConnectivity.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GextUtils.dart';
import 'package:app_turismo/Recursos/Models/InfoMunicipio.dart';
import 'package:flutter/material.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GetxInformationMunicipio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'RegisterMunicipality.dart';

class ListMunicipality extends GetView<GetxInformationMunicipio> {
  final ConnectivityController connectivityController = Get.put(ConnectivityController());

  final GetxUtils controllerUtils = Get.put(GetxUtils());
  late InfoMunicipio infoMunicipio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Información"),
        actions: [
          TextButton(
            child: Text("Añadir subtitulos", style: TextStyle(color: Colors.white),),
              onPressed: () {
                if (!controller.infoExists.value && !connectivityController.isOnline.value) {
                  controllerUtils.messageWarning("Infromacion", "Ups! Sin conexion a internet.");
                } else {
                  actionForms();
                  Get.to(() => RegisterMunicipality(), transition: Transition.leftToRight);
                }
                controller.update();
              },
              )
        ],
      ),
      body: informationList(),
    );
  }

  Widget informationList() {
    bool conexionEnable = false;
    return Container(
        color: Colors.grey.shade200,
        child: SafeArea(
            child: StreamBuilder<QuerySnapshot>(
                stream: controller.listInfo(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (connectivityController.isOnline.value) {
                    if (snapshot.hasError) {
                      return const Center(child: Text('Lo sentimos se ha producido un error.'));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Cargando Datos"),
                          SizedBox(height: 10),
                          LoadingAnimationWidget.discreteCircle(
                              color: Colors.white,
                              size: 25,
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
                              width: 100,
                              height: 100,
                            ),
                            TextButton(
                              onPressed: () {
                                controller.titleAppbar.value = "Agregar Titulo";
                                Get.to(() => RegisterMunicipality(), transition: Transition.leftToRight);
                              },
                              child: Text("Registrar Informacion",
                                  style: TextStyle(color: Colors.green, fontSize: 15)),
                            )
                          ]),
                        ),
                      );
                    } else if (conexionEnable == true) {
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
                  } else {
                    controller.infoExists.value = false;
                    return controllerUtils.imageInformation("assets/img/no-internet.png", "Sin conexion a internet");
                  }
                })));
  }

  List<Widget> listSubinformation(InfoMunicipio infoMunicipio, BuildContext context) {
    List<Widget> information = [];
    int index = 0;

    ListTile mainTitle = ListTile(
      title: Text("Titulo principal"),
      subtitle: Text(infoMunicipio.nombre),
    );
    information.add(dismissibleWidGet(context, infoMunicipio, mainTitle, -1));

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
          if (direction == DismissDirection.startToEnd) {
            await menssageAlert("Actualizar", infoMunicipio, index, context);
          } else {
            await menssageAlert("Eliminar", infoMunicipio, index, context);
          }
        },
        child: listTile);
  }

  Future<bool?> menssageAlert(
      String titulo, InfoMunicipio infoMunicipio, int index, BuildContext context) async {
    String mensage;
    if (index == -1) {
      if (titulo == "Actualizar") {
        mensage = "Actualizar el titulo principal?";
      } else {
        mensage = "Eliminar todos los datos ?";
      }
    } else {
      mensage = "${titulo} el subtitulo?";
    }

    final bool? confirmation = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(titulo),
            content: Text("Seguro de ${mensage}"),
            actions: <Widget>[
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    if (titulo == "Actualizar" && connectivityController.isOnline.value) {
                      controller.updateInforMunicipio(infoMunicipio, index);
                      Get.to(() => RegisterMunicipality(), transition: Transition.leftToRight);
                    } else if (titulo == "Eliminar" && connectivityController.isOnline.value) {
                      print("Index a eliminar: ${index}" + " ID Documento: ${infoMunicipio.id.toString()}");
                      controller.deleteMapFromList(infoMunicipio.id.toString(), index);
                    } else if (connectivityController.isOnline.value == false) {
                      controllerUtils.messageError("Conexion", "No se tiene conexion a internet.");
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

  void actionForms() {
    controller.cleanForm();
    controller.infoMunicipioUpdate = infoMunicipio;
    controller.titleAppbar.value = "Agregar Subtitulo";
    controller.buttonTextSave.value = "Agregar";
    controller.isSaveInformation.value = true;
    controller.isUpdateInformation.value = false;
  }
}
