import 'package:app_turismo/Recursos/Controller/GextControllers/GetxInformationMunicipio.dart';
import 'package:app_turismo/Recursos/Models/InfoMunicipio.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/ImageUpload.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/MapGeolocation.dart';
import 'package:app_turismo/Recursos/Widgets/custom_TextFormField.dart';
import 'package:app_turismo/Recursos/theme/app_theme.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../Models/SubInfoMunicipio.dart';

class InformationMunicipio extends GetView<GetxInformationMunicipio> {
  const InformationMunicipio({super.key});

  @override
  Widget build(BuildContext context) {
    return Formulario();
  }

  Widget Formulario() {
    return Form(
        child: Column(
      children: [
        CustomTextFormField(
            icon: const Icon(BootstrapIcons.info_circle),
            obscureText: false,
            textGuide: "Titulo informativo",
            msgError: "Campo obligatorio.",
            textInputType: TextInputType.text,
            fillColor: AppBasicColors.colorTextFormField,
            controller: controller.tituloControl,
            valueFocus: false),
        SizedBox(height: 15),
        CustomTextFormField(
            icon: const Icon(BootstrapIcons.info_circle),
            obscureText: false,
            textGuide: "Descripcion informativa",
            msgError: "Campo obligatorio.",
            textInputType: TextInputType.text,
            fillColor: AppBasicColors.colorTextFormField,
            controller: controller.descriptionControl,
            valueFocus: false,
            maxLinesText: 3),
        SizedBox(height: 15),
        CustomTextFormField(
            icon: const Icon(BootstrapIcons.info_circle),
            obscureText: false,
            textGuide: "Sub Titulo informativo",
            msgError: "Campo obligatorio.",
            textInputType: TextInputType.text,
            fillColor: AppBasicColors.colorTextFormField,
            controller: controller.subTituloControl,
            valueFocus: false),
        SizedBox(height: 15),
        CustomTextFormField(
            icon: const Icon(BootstrapIcons.info_circle),
            obscureText: false,
            textGuide: "Descripcion informativa",
            msgError: "Campo obligatorio.",
            textInputType: TextInputType.text,
            fillColor: AppBasicColors.colorTextFormField,
            controller: controller.subDescriptionControl,
            valueFocus: false,
            maxLinesText: 3),
        SizedBox(height: 7),
        Row(
          children: [
            Text("Ubicado Mostrar Mapa"),
            TextButton.icon(
                onPressed: () {
                  Get.to(() => MapGeolocation());
                },
                icon: Icon(
                  Icons.location_on,
                  color: Colors.green,
                ),
                label: Text(
                  "Ubicar",
                  style: TextStyle(color: Colors.green),
                ))
          ],
        ),
        Column(
          children: [
            Container(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/img/photo.png",
                  width: 60,
                  height: 60,
                )),
            ElevatedButton.icon(
              label: Text("Cargar fotos"),
              onPressed: () => Get.to(() => ImageUpload()),
              icon: Icon(Icons.image_outlined, color: Colors.white),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Informacion adicional : 0"),
            ElevatedButton.icon(
                onPressed: () {
                  SubInfoMunicipio subInfoMunicipio = SubInfoMunicipio(
                      titulo: controller.subTituloControl.text,
                      descripcion: controller.subDescriptionControl.text,
                      listPhotosFiles: [],
                      listPhotosPath: []
                  );

                  controller.addSubinformation(subInfoMunicipio);
                  print("agregando SUb info");

                }, icon: const Icon(BootstrapIcons.save), label: Text("Agregar"))
          ],
        ),
        ElevatedButton.icon(
            onPressed: () {
              InfoMunicipio infoMunicipio = InfoMunicipio(id: '',
                  nombre: controller.tituloControl.text,
                  descripcion: controller.descriptionControl.text,
                  subTitulos: [], ubicacion: {});

              controller.saveGestion(infoMunicipio);
            }, icon: const Icon(BootstrapIcons.upload), label: Text("Guardar"))
      ],
    ));
  }
}
