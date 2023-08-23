import 'package:app_turismo/Recursos/Controller/GextControllers/GetxInformationMunicipio.dart';
import 'package:app_turismo/Recursos/Widgets/custom_TextFormField.dart';
import 'package:app_turismo/Recursos/theme/app_theme.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

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
            controller: controller.tituloControl,
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
            controller: controller.tituloControl,
            valueFocus: false,
            maxLinesText: 3),
        SizedBox(height: 7),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Informacion adicional : 0"),
            ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(BootstrapIcons.save),
                label: Text("Agregar"))
          ],
        ),
        ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(BootstrapIcons.upload),
                label: Text("Guardar"))
      ],
    ));
  }
}
