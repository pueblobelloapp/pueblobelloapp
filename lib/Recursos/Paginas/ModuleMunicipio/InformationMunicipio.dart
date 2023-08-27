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

import '../../Controller/GextControllers/GetxSitioTuristico.dart';

class InformationMunicipio extends GetView<GetxInformationMunicipio> {
  final GetxSitioTuristico sitioController = Get.put(GetxSitioTuristico());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(15),
      reverse: true,
      child: Formulario(),
    );
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
            textGuide: "Porque vistar?",
            msgError: "Campo obligatorio.",
            textInputType: TextInputType.text,
            fillColor: AppBasicColors.colorTextFormField,
            controller: controller.whyVisitControl,
            valueFocus: false,
            maxLinesText: 4),
        SizedBox(height: 15),
        ListInformation(controller.subCategoria, controller.dropdownItems, "Seleccionar"),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
                onPressed: () {
                  Get.to(() => MapGeolocation());
                },
                icon: Icon(Icons.location_on, color: Colors.white),
                label: Text("Ubicar")),
            SizedBox(width: 10),
            ElevatedButton.icon(
              label: Text("Fotografias"),
              onPressed: () async {
                await Get.to(() => ImageUpload());
                if (sitioController.listCroppedFile.length > 0) {
                  controller.addPhotosGeneral(sitioController.listCroppedFile);
                } else {
                  print("No seleccionaste fotografias.");
                }
                sitioController.listCroppedFile.clear();
              },
              icon: Icon(Icons.image_outlined, color: Colors.white),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            )
          ],
        ),
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
        ElevatedButton.icon(
            label: Text("Cargar fotos"),
            onPressed: () async {
              await Get.to(() => ImageUpload());
              if (sitioController.listCroppedFile.length > 0) {
                controller.addPhotosSub(sitioController.listCroppedFile);
              } else {
                print("No seleccionaste fotografias.");
              }
            },
            icon: Icon(Icons.image_outlined, color: Colors.white)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Informacion adicional : 0"),
            ElevatedButton.icon(
                onPressed: () {
                  SubTitulo subInfoMunicipio = SubTitulo(
                      titulo: controller.subTituloControl.text,
                      descripcion: controller.subDescriptionControl.text,
                      listPhotosPath: controller.listPhotosSubInfo);

                  controller.addSubinformation(subInfoMunicipio);
                  sitioController.listCroppedFile.clear();
                  print("agregando SUb info");
                },
                icon: const Icon(BootstrapIcons.save),
                label: Text("Añadir"))
          ],
        ),
        ElevatedButton.icon(
            onPressed: () {
              InfoMunicipio infoMunicipio = InfoMunicipio(
                  id: '',
                  nombre: controller.tituloControl.text,
                  descripcion: controller.descriptionControl.text,
                  subTitulos: controller.listSubInformation,
                  ubicacion: sitioController.mapUbications,
                  photos: controller.listPhotosInfo,
                  subCategoria: controller.subCategoria.text,
                  whyVisit: controller.whyVisitControl.text);

              controller.saveGestion(infoMunicipio);
            },
            icon: const Icon(BootstrapIcons.upload),
            label: Text("Guardar"))
      ],
    ));
  }

  Widget ListInformation(TextEditingController _tipoTurismo,
      List<DropdownMenuItem<String>> listInformation, String hintextValue) {
    return DropdownButtonFormField<String>(
      decoration: AppBasicColors.inputDecorationText,
      isExpanded: true,
      dropdownColor: AppBasicColors.colorTextFormField,
      icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.white),
      items: listInformation,
      onChanged: (String? value) {
        print("Valor combo: " + value.toString());
        controller.subCategoria.text = value!;
      },
      hint: Text(hintextValue, style: TextStyle(color: Colors.black26)),
    );
  }
}
