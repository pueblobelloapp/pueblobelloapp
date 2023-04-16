import 'dart:io';

import 'package:app_turismo/Recursos/Constants/Constans.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GextPropietarioController.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GextUtils.dart';
import 'package:app_turismo/Recursos/Controller/LoginController.dart';
import 'package:app_turismo/Recursos/Controller/PropietarioController.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/HeaderProfile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PerfilPropietario extends StatefulWidget {
  @override
  State<PerfilPropietario> createState() => _PerfilPropietarioState();
}

class _PerfilPropietarioState extends State<PerfilPropietario> {
  ControllerLogin controllerLogin = Get.find();
  final PropietarioController controllerPropietario =
      Get.put(PropietarioController());
  final GetxUtils messageController = Get.put(GetxUtils());
  final GextPropietarioController _propietarioController =
      Get.put(GextPropietarioController());

  TextEditingController contactController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordValidateController = TextEditingController();

  Map<String, dynamic> informationUser = {};
  StepperType stepperType = StepperType.vertical;
  int _currentStep = 0;

  bool updateUser = false;
  bool isValid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: Text(
            "Mi perfil",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.white),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                  Colors.green.shade400,
                  Colors.green.shade600,
                ])),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(
                top: 16,
                right: 16,
              ),
              child: Stack(
                children: <Widget>[
                  IconButton(
                      onPressed: () => enableBox(),
                      icon: FaIcon(
                        FontAwesomeIcons.pen,
                        color: Colors.white,
                        size: 20,
                      ))
                ],
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Stack(children: [HeaderImage(), BodyApp()])));
  }

  Widget HeaderImage() {
    return Container(height: 100, child: HeaderProfile(100));
  }

  Widget BodyApp() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(10, 30, 10, 5),
      padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
      child: Column(
        children: [
          SizedBox(
            height: 125,
            width: 125,
            child: Stack(
              clipBehavior: Clip.none,
              fit: StackFit.expand,
              children: [
                Obx(() => CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage:
                        _propietarioController.imagePerfilUrl.isEmpty
                            ? AssetImage('assets/Icons/usuarioPerfil.png')
                            : NetworkImage(_propietarioController.imagePerfilUrl
                                .toString()) as ImageProvider)),
                Positioned(
                    bottom: 0,
                    right: -25,
                    child: RawMaterialButton(
                      onPressed: () async {
                        selectMultPhoto();
                        controllerPropietario.saveImageProfile();
                      },
                      elevation: 2.0,
                      fillColor: Color(0xFFF5F6F9),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.blue,
                      ),
                      padding: EdgeInsets.all(10.0),
                      shape: CircleBorder(),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                Card(
                    elevation: 4,
                    child: Container(child: listViewInformation())),
              ],
            ),
          ),
          updateUser ? buttonOption() : Container()
        ],
      ),
    );
  }

  selectMultPhoto() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? selectedImage =
          await _picker.pickImage(source: ImageSource.gallery);

      if (selectedImage != null) {
        _propietarioController.updateImagePerfil(selectedImage);
      }
    } catch (e) {
      messageController.messageWarning(
          "Fotografias", "No pudimos seleccionar las fotografias");
    }
  }

  enableBox() {
    informationUser = controllerLogin.dataUsuario;
    emailController.text = informationUser["correo"];
    nameController.text = informationUser["nombre"];
    contactController.text = informationUser["contacto"];
    ageController.text = informationUser["edad"];
    genderController.text = informationUser["genero"];
    setState(() {
      updateUser = true;
    });
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  clearForm() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    contactController.clear();
    ageController.clear();
    genderController.clear();
  }

  Widget buttonContinue(buildContext, details) {
    return Row(
      children: [
        _currentStep == 0
            ? ElevatedButton(
                onPressed: continued,
                child: const Text("Continuar"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green))
            : ElevatedButton(
                onPressed: cancel,
                child: const Text("Atras"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green))
      ],
    );
  }

  //Boton para cancelar la actualizacion
  Widget buttonOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            style: Constants.buttonPrimary,
            onPressed: () {
              saveInformation();
            },
            child: Text("Actualizar")),
        SizedBox(width: 15),
        ElevatedButton(
            style: Constants.buttonCancel,
            onPressed: () {
              setState(() {
                informationUser = controllerLogin.dataUsuario;
                updateUser = false;
              });
            },
            child: Text("Calcelar"))
      ],
    );
  }

  void saveInformation() {
    if (emailController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty &&
        nameController.text.trim().isNotEmpty &&
        contactController.text.trim().isNotEmpty &&
        ageController.text.trim().isNotEmpty &&
        genderController.text.trim().isNotEmpty) {
      informationUser['contacto'] = contactController.text.trim();
      informationUser['edad'] = ageController.text.trim();
      informationUser['genero'] = genderController.text.trim();
      informationUser['nombre'] = nameController.text.trim();
      informationUser['correo'] = emailController.text.trim();

      controllerPropietario
          .savePropietario(
              informationUser['id'],
              informationUser['nombre'],
              informationUser['rool'],
              informationUser['edad'],
              informationUser['genero'],
              informationUser['correo'],
              informationUser['contacto'])
          .then((value) => {
                messageController.messageInfo(
                    "Actualziacion", "Se actualizaron los datos."),
                clearForm(),
                setState(() {
                  updateUser = false;
                })
              })
          .catchError(
              (error) => {informationUser = controllerLogin.dataUsuario});
    } else {
      messageController.messageError("Validacion", "Complete campos faltanes");
    }
  }

  Widget listViewInformation() {
    return Stepper(
        type: StepperType.vertical,
        physics: ScrollPhysics(),
        currentStep: _currentStep,
        onStepTapped: (step) => tapped(step),
        controlsBuilder: buttonContinue,
        steps: <Step>[
          Step(
            title: new Text('Informacion personal'),
            content: Column(
              children: <Widget>[
                listTileInformation(
                    nameController, "Nombre", TextInputType.text),
                listTileInformation(
                    contactController, "Contacto", TextInputType.number),
                listTileInformation(
                    genderController, "Genero", TextInputType.text),
                listTileInformation(
                    ageController, "Edad", TextInputType.number),
              ],
            ),
            isActive: _currentStep >= 0,
          ),
          Step(
              title: new Text('Datos electronicos'),
              content: Column(
                children: <Widget>[
                  listTileInformation(
                      emailController, "Correo", TextInputType.text),
                  listTileInformation(
                      passwordController, "Contraseña", TextInputType.text)
                ],
              ),
              isActive: _currentStep >= 0),
        ]);
  }

  Widget listTileInformation(TextEditingController controller, String title,
      TextInputType textInputType) {
    return ListTile(
        title: Text(title),
        subtitle: updateUser
            ? boxField(controller, "Campo requerido", textInputType)
            : Text(
                controllerLogin.dataUsuario[title.toLowerCase().trim()] != null
                    ? controllerLogin.dataUsuario[title.toLowerCase().trim()]
                    : title == "Contraseña"
                        ? "**********"
                        : "Sin datos"));
  }

  Widget boxField(TextEditingController controlador, String msgError,
      TextInputType textInputType) {
    return TextField(
      controller: controlador,
      keyboardType: textInputType,
      decoration: InputDecoration(
          errorText: controlador.text.isEmpty ? msgError : null,
          isCollapsed: true),
      cursorColor: Colors.green,
    );
  }
}
