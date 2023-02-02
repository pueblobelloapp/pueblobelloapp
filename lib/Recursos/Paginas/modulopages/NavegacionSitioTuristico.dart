import 'package:app_turismo/Recursos/Controller/GextControllers/GexTurismo.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/ListaSitiosTuristicos.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/ModuleSitiosTuristico.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class NavegacionSitioTuristico extends StatelessWidget {
  const NavegacionSitioTuristico({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final GextControllerTurismo controllerTurismo =
    Get.put(GextControllerTurismo());

    return GetBuilder<GextControllerTurismo>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text("App Turismo"),
        ),
        body: SafeArea(
          child: IndexedStack(
            index: controller.countTapItem,
            children: [
              ListaSitiosTuristicos(),
              ModuleSitiosTuristico()
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.list),
              label: 'Listado',
            ),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.plus), label: 'Agregar'),
          ],
          currentIndex: controller.countTapItem,
          onTap: controller.updateTapItem,
          backgroundColor: Colors.green,
          selectedItemColor: Colors.white,
        ),
      );
    });
  }
}
