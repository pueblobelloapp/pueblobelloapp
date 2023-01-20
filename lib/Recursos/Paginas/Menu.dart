import 'package:app_turismo/Recursos/Controller/GextControllers/GexTurismo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MenuModuls extends StatelessWidget {
  MenuModuls({super.key});

  final GextControllerTurismo _controllerTurismo =
      Get.put(GextControllerTurismo());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green.shade400,
        automaticallyImplyLeading: false,
        title: const Text("Gestion de modulos"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: ListTile.divideTiles(context: context, tiles: [
          _title(
              "Sitios turisticos",
              FaIcon(FontAwesomeIcons.mapLocationDot, color: Colors.green),
              "ModuleSitios",
              ""),
          _title(
              "Culturas",
              FaIcon(FontAwesomeIcons.award, color: Colors.green),
              "MenuGestion",
              "cultura"),
          _title(
              "Gastronomias",
              FaIcon(FontAwesomeIcons.bowlFood, color: Colors.green),
              "MenuGestion",
              "gastronomia"),
          _title(
              "Festividades",
              FaIcon(FontAwesomeIcons.calendar, color: Colors.green),
              "MenuGestion",
              "festividad"),
          _title(
              "Religiones",
              FaIcon(FontAwesomeIcons.church, color: Colors.green),
              "MenuGestion",
              "religion"),
          _title(
              "Propietarios",
              FaIcon(FontAwesomeIcons.userGear, color: Colors.green),
              "MenuPropietario",
              "")
        ]).toList(),
      ),
    );
  }

  Widget _title(
      String title, FaIcon icono, String route, String nombreGestion) {
    return ListTile(
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 17)),
        leading: icono,
        trailing: Icon(
          Icons.keyboard_arrow_right_rounded,
          color: Colors.green,
        ),
        onTap: () {
          Get.toNamed(route);
          _controllerTurismo.tipoGestion(nombreGestion);
        });
  }
}
