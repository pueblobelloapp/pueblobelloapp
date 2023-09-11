import 'package:app_turismo/Recursos/Controller/GextControllers/GetxInformationMunicipio.dart';
import 'package:app_turismo/Recursos/Paginas/ModuleMunicipio/ListInformationMunicipio.dart';
import 'package:app_turismo/Recursos/Paginas/ModuleMunicipio/InformationMunicipio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class NavegacionGestion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetxInformationMunicipio>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: Text("Modulo de ${controller.tipoGestion}"),
        ),
        body: SafeArea(
          child: IndexedStack(
            index: controller.countTapItem,
            children: [ListInformationMunicipio(), InformationMunicipio()],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.list),
              label: 'Listado',
            ),
            BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.plus), label: 'Agregar'),
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
