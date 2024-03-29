import 'package:app_turismo/Recursos/Constants/Constans.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GetxInformationMunicipio.dart';
import 'package:app_turismo/Recursos/Controller/LoginController.dart';
import 'package:app_turismo/Recursos/Paginas/Login.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/TouristSiteOwner.dart';
import 'package:app_turismo/Recursos/SystemNavegation/Routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MenuModuls extends StatefulWidget {
  @override
  State<MenuModuls> createState() => _MenuModulsState();
}

class _MenuModulsState extends State<MenuModuls> {
  final GetxInformationMunicipio _controllerTurismo = Get.put(GetxInformationMunicipio());

  final ControllerLogin controladorLogin = Get.put(ControllerLogin());
  bool shouldPop = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.green.shade400,
              automaticallyImplyLeading: false,
              title: const Text("Gestion de modulos"),
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                closeSesion();
              },
              label: const Text("Salir"),
              icon: const Icon(Icons.exit_to_app_outlined),
              backgroundColor: Colors.red,
            ),
            body: controladorLogin.userRole == "true"
                ? _listPropietario(context)
                : _listAdmin(context)),
        onWillPop: () async => false);
  }

  Widget _listPropietario(BuildContext context) {
    return ListView(
        padding: const EdgeInsets.all(8),
        children: ListTile.divideTiles(context: context, tiles: [
          _title("Mis sitios turisticos", 
              FaIcon(FontAwesomeIcons.mapLocationDot, color: Colors.green), "MenuSitioTuristico"),
          _title(
              "Mi perfil", FaIcon(FontAwesomeIcons.userGear, color: Colors.green), "Propietario"),
        ]).toList());
  }

  Widget _listAdmin(BuildContext context) {
    return ListView(
        padding: const EdgeInsets.all(5),
        children: ListTile.divideTiles(context: context, tiles: [
          _title("Culturas", FaIcon(FontAwesomeIcons.peopleArrows, color: Colors.green),
              "ListInformation"),
          _title("Etnoturismo", FaIcon(FontAwesomeIcons.mountainSun, color: Colors.green),
              "ListInformation"),
          _title("municipio", FaIcon(FontAwesomeIcons.landmarkDome, color: Colors.green),
              "ListInformation"),
          _title("Propietarios", FaIcon(FontAwesomeIcons.userTie, color: Colors.green),
              "ListInformation")
        ]).toList());
  }

  Widget _title(String title, FaIcon icono, String route) {
    return ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 17)),
        leading: icono,
        trailing: Icon(
          Icons.keyboard_arrow_right_rounded,
          color: Colors.green,
        ),
        onTap: () {
          if (title == "Propietarios") {
            Get.to(() => TouristSiteOwner());
            return;
          }
          _controllerTurismo.tipoGestion = title;
          Get.toNamed(route);
        });
  }

  void closeSesion() {
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
                    setState(() => shouldPop = true);
                    controladorLogin.signOut();
                    Navigator.of(context).pop();
                    Get.to(() => Login());
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
