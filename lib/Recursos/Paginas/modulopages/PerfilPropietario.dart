import 'package:app_turismo/Recursos/Controller/GextControllers/GextPropietarioController.dart';
import 'package:app_turismo/Recursos/Controller/LoginController.dart';
import 'package:app_turismo/Recursos/Controller/PropietarioController.dart';
import 'package:app_turismo/Recursos/Models/PropietarioModel.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/HeaderProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class PerfilPropietario extends StatelessWidget {
  //const PerfilPropietario({Key? key}) : super(key: key);
  ControllerLogin controllerLogin = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: Text(
            "Mi perfil",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.white),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                  Colors.green.shade400,
                  Colors.green.shade600,
                ])),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(
                top: 16,
                right: 16,
              ),
              child: Stack(
                children: <Widget>[
                  FaIcon(
                    FontAwesomeIcons.pen,
                    color: Colors.white,
                    size: 20,
                  )
                ],
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Stack(children: [HeaderImage(), BodyApp()])));
  }

  Widget HeaderImage() {
    return Container(height: 100, child: HeaderProfile(100));
  }

  Widget BodyApp() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(10, 30, 10, 5),
      padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 5, color: Colors.white),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20,
                  offset: const Offset(5, 5),
                ),
              ],
            ),
            child: Icon(
              Icons.person,
              size: 80,
              color: Colors.grey.shade300,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            controllerLogin.dataUsuario['nombre'],
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                Card(
                  elevation: 7,
                  child: Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            ...ListTile.divideTiles(
                              color: Colors.grey,
                              tiles: [
                                ListTile(
                                  leading: FaIcon(
                                    FontAwesomeIcons.solidEnvelope,
                                    color: Colors.green,
                                  ),
                                  title: Text("Email"),
                                  subtitle: Text(
                                      controllerLogin.dataUsuario['correo']),
                                ),
                                ListTile(
                                  leading: FaIcon(
                                    FontAwesomeIcons.phone,
                                    color: Colors.green,
                                  ),
                                  title: Text("Contacto"),
                                  subtitle: Text(
                                      controllerLogin.dataUsuario['contacto']),
                                ),
                                ListTile(
                                  leading: FaIcon(
                                    FontAwesomeIcons.person,
                                    color: Colors.green,
                                  ),
                                  title: Text("Genero"),
                                  subtitle: Text(
                                      controllerLogin.dataUsuario['genero']),
                                ),
                                ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  leading: FaIcon(
                                    FontAwesomeIcons.idCard,
                                    color: Colors.green,
                                  ),
                                  title: Text("edad"),
                                  subtitle:
                                      Text(controllerLogin.dataUsuario['edad']),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
