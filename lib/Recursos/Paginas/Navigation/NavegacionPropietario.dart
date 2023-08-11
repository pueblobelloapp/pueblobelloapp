import 'package:app_turismo/Recursos/Controller/GextControllers/GextPropietarioController.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/ListaPropietario.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../modulopages/ModulePropietario.dart';

class NavegacionPropietario extends StatelessWidget {

  final GextPropietarioController propietarioController =
      Get.put(GextPropietarioController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GextPropietarioController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: Text("App Turismo"),
        ),
        body: SafeArea(
          child: IndexedStack(
            index: controller.countTapItem,
            children: [
              ListaPropietario(),
              ModulePropietario()
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
