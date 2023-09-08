import 'package:app_turismo/Recursos/Controller/GextControllers/GetxSitioTuristico.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GextUtils.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/MapGeolocation.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/ImageUpload.dart';
import 'package:app_turismo/Recursos/Widgets/custom_TextFormField.dart';
import 'package:app_turismo/Recursos/theme/app_theme.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ModuleSitiosTuristicos extends GetView<GetxSitioTuristico> {
  final GetxUtils messageController = Get.put(GetxUtils());
  void onInit() {
    controller.dropdownActivity;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Formulario(),
    );
  }

  Widget Formulario() {
    return Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Nombre", textDirection: TextDirection.rtl),
                CustomTextFormField(
                    icon: const Icon(BootstrapIcons.info_circle),
                    obscureText: false,
                    textGuide: "Sitio turistico.",
                    msgError: "Campo obligatorio.",
                    textInputType: TextInputType.text,
                    fillColor: AppBasicColors.colorTextFormField,
                    controller: controller.nombreSitio,
                    valueFocus: false),
                SizedBox(height: 15),
                CustomTextFormField(
                    icon: const Icon(BootstrapIcons.info_circle),
                    obscureText: false,
                    textGuide: "Descripcion del sitio.",
                    msgError: "Campo obligatorio.",
                    textInputType: TextInputType.text,
                    fillColor: AppBasicColors.colorTextFormField,
                    controller: controller.descripcionST,
                    maxLinesText: 4),
                SizedBox(height: 15),
                Text("Tipo de turismo"),
                ListInformation(controller.tipoTurismo, controller.dropdownItems, "Seleccionar"),
                SizedBox(height: 15),
                Text("Actividades"),
                Container(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: controller.dropdownActivity(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Center(child: Text('Lo sentimos se ha producido un error.'));
                        }
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: Text('Cargando datos.'));
                        }
                        if (snapshot.data!.docs.isEmpty) {
                          return const Center(child: Text('Registra sitios turisticos.'));
                        }
                        return MultiSelectDialogField(
                          title: Text("Seleccion multiple"),
                          confirmText: Text("CONFIRMAR"),
                          buttonText: Text("Seleccionar"),
                          items: snapshot.data!.docs.map((DocumentSnapshot document) {
                            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                            return ListActivitys(data);
                          }).single,
                          listType: MultiSelectListType.LIST,
                          onConfirm: (values) {
                            if (values.isNotEmpty) {
                              controller.updateActivity(values);
                            }
                          },
                          initialValue: [],
                        );
                      }),
                ),
                SizedBox(height: 15),
                Text("Contactos"),
                CustomTextFormField(
                    icon: const Icon(BootstrapIcons.twitter),
                    obscureText: false,
                    textGuide: "Twitter del sitio",
                    msgError: "",
                    textInputType: TextInputType.text,
                    fillColor: AppBasicColors.colorTextFormField,
                    controller: controller.twitterTextController),
                SizedBox(height: 15),
                CustomTextFormField(
                    icon: const Icon(BootstrapIcons.messenger),
                    obscureText: false,
                    textGuide: "Messenger del sitio",
                    msgError: "",
                    textInputType: TextInputType.text,
                    fillColor: AppBasicColors.colorTextFormField,
                    controller: controller.messengerTextController),
                SizedBox(height: 15),
                CustomTextFormField(
                    icon: const Icon(BootstrapIcons.instagram),
                    obscureText: false,
                    textGuide: "Instagram del sitio",
                    msgError: "",
                    textInputType: TextInputType.text,
                    fillColor: AppBasicColors.colorTextFormField,
                    controller: controller.instagramTextController),
                SizedBox(height: 15),
                CustomTextFormField(
                    icon: const Icon(BootstrapIcons.whatsapp),
                    obscureText: false,
                    textGuide: "Whatsapp del sitio",
                    msgError: "",
                    textInputType: TextInputType.text,
                    fillColor: AppBasicColors.colorTextFormField,
                    controller: controller.whatsappTextController),
                SizedBox(height: 15),
                CustomTextFormField(
                    icon: const Icon(BootstrapIcons.facebook),
                    obscureText: false,
                    textGuide: "Facebook del sitio",
                    msgError: "",
                    textInputType: TextInputType.text,
                    fillColor: AppBasicColors.colorTextFormField,
                    controller: controller.facebookTextController),
                SizedBox(height: 15),
                Row(
                  children: [
                    Obx(() => Text(controller.ubicacion.value)),
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
                SizedBox(height: 15),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        if (controller.listCroppedFile.isNotEmpty) {
                          print(controller.mapUbications.toFirebaseMap());
                          controller.validateForms();
                        } else {
                          print("Agregar fotos ");
                          messageController.messageWarning(
                              "Fotos", "Selecciona fotografias para continuar");
                        }
                      },
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.green,
                          textStyle: const TextStyle(fontSize: 15)),
                      child: const Text("Guardar"),
                    )
                  ],
                )
              ],
            )));
  }

  List<MultiSelectItem<dynamic>> ListActivitys(Map<String, dynamic> data) {
    List<MultiSelectItem<dynamic>> menuItems = [];
    for (String actividad in data['activity']) {
      menuItems.add(MultiSelectItem<dynamic>(actividad, actividad));
    }
    return menuItems;
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
        controller.tipoTurismo.text = value!;
      },
      hint: Text(hintextValue, style: TextStyle(color: Colors.black26)),
    );
  }
}
