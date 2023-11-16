import 'dart:io';

import 'package:app_turismo/Recursos/Controller/GextControllers/GetxInformationMunicipio.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GextUtils.dart';
import 'package:app_turismo/Recursos/Models/InfoMunicipio.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/ImageUpload.dart';
import 'package:app_turismo/Recursos/Widgets/carousel_photos.dart';
import 'package:app_turismo/Recursos/Widgets/custom_TextFormField.dart';
import 'package:app_turismo/Recursos/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ListMunicipality.dart';

class RegisterMunicipality extends GetView<GetxInformationMunicipio> {
  final GetxUtils messageController = Get.put(GetxUtils());
  final ImageUpload imageUpload = Get.put(ImageUpload());
  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Obx(() => Text(controller.titleAppbar.value))),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        reverse: true,
        child: FormData(),
      ),
    );
  }

  Widget FormData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [formRegister(), buttonUpdate()],
    );
  }

  Widget formRegister() {
    return Form(
        key: keyForm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselPhotos(),
            SizedBox(height: 20),
            Text(
              'Título',
              style: TextStyle(color: AppBasicColors.green, fontSize: 16.0),
            ),
            SizedBox(height: 3),
            CustomTextFormField(
                //icon: const Icon(BootstrapIcons.info_circle),
                obscureText: false,
                textGuide: "Ingrese el título",
                msgError: "Campo obligatorio.",
                textInputType: TextInputType.text,
                fillColor: AppBasicColors.colorTextFormField,
                controller: this.controller.tituloControl,
                valueFocus: false),
            SizedBox(height: 10),
            Text(
              'Descripción',
              style: TextStyle(color: AppBasicColors.green, fontSize: 16.0),
            ),
            SizedBox(height: 3),
            CustomTextFormField(
                obscureText: false,
                textGuide: "Ingrese la descripción",
                msgError: "Campo obligatorio.",
                textInputType: TextInputType.text,
                fillColor: AppBasicColors.colorTextFormField,
                controller: this.controller.descriptionControl,
                valueFocus: false,
                maxLinesText: 6),
            SizedBox(height: 20)
          ],
        ));
  }

  Widget buttonUpdate() {
    return Row(children: [
      Expanded(
          child: SizedBox(
              height: 50.0,
              child: ElevatedButton(
                  onPressed: () async {
                    bool validation = false;

                    if (keyForm.currentState!.validate()) {
                      validation = true;
                    }

                    if (validation) {
                      if (controller.infoExists.value == false) {
                        //TODO: No existe informacion se agrega un titulo principal
                        InfoMunicipio municipaity = InfoMunicipio(
                            id: controller.uuidGenerate(),
                            nombre: controller.tituloControl.text.trim(),
                            descripcion: controller.descriptionControl.text.trim(),
                            subCategoria: controller.tipoGestion,
                            photos: controller.listCroppedFile,
                            subTitulos: []);
                        if (controller.listCroppedFile.isEmpty) {
                          messageController.messageError("Informacion", "Selecciona fotografias.");
                        } else {
                          controller.saveInformation(municipaity);
                        }
                      } else {
                        //TODO: existe informacion, se actualiza el dato o agrega
                        if (controller.isSaveInformation.isTrue) {
                          SubTitulo subTitle = SubTitulo(
                              titulo: controller.tituloControl.text,
                              descripcion: controller.descriptionControl.text,
                              listPhotosPath: controller.listCroppedFile);
                          controller.infoMunicipioUpdate.subTitulos.add(subTitle);
                          await controller.updateInformation().then((value) {
                            controller.cleanForm();
                            Get.to(() => ListMunicipality(), transition: Transition.rightToLeft);
                          }).onError((error, stackTrace) {
                            messageController.messageError("Error", "Error inesperado: ${error}");
                          });
                        } else if (controller.isUpdateInformation.isTrue &&
                            controller.validateInformationEquals()) {
                          await controller.updateInformation().then((value) {
                            controller.cleanForm();
                            Get.to(() => ListMunicipality(), transition: Transition.rightToLeft);
                          }).onError((error, stackTrace) {
                            messageController.messageError("Error", "Error inesperado: ${error}");
                          });
                        } else {
                          //TODO: Entonces elimina la informacion.
                        }
                      }
                    } else {
                      messageController.messageError(
                          "Validacion", "Complete los campos faltantes.");
                    }
                  },
                  child: Obx(() => Text(
                        controller.buttonTextSave.value,
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ))))),
      SizedBox(width: 15),
      Expanded(
          child: SizedBox(
        height: 50.0,
        child: ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
            onPressed: () {
              //Aca debe volver a la pagina anterior.
              controller.cleanForm();
              controller.update();
              Get.back();
            },
            child: Text("Cancelar", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))),
      ))
    ]);
  }
}
