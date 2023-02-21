import 'package:app_turismo/Recursos/Constants/Constans.dart';
import 'package:app_turismo/Recursos/Controller/LoginController.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/HeaderProfile.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecuperarPassword extends StatefulWidget {
  const RecuperarPassword({Key? key}) : super(key: key);

  @override
  State<RecuperarPassword> createState() => _RecuperarPasswordState();
}

class _RecuperarPasswordState extends State<RecuperarPassword> {
  TextEditingController _email = TextEditingController();
  ControllerLogin controllerLogin = Get.find();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      HeaderImage(),
      SizedBox(height: 100),
      FormRegister()
    ])));
  }

  Widget HeaderImage() {
    return Container(height: 100, child: HeaderProfile(100));
  }

  Widget FormRegister() {
    return Padding(
        padding: EdgeInsets.all(20),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            shadowColor: Colors.black,
            child: Form(
                key: _formkey,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      AutoSizeText(
                        "Recibiras un correo para restablecer la contraseña",
                        style: TextStyle(fontSize: 25, color: Colors.green),
                        maxLines: 2,
                        minFontSize: 18,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      AutoSizeText("Ingrese correo electronico",
                          style: TextStyle(
                              color: Colors.grey.shade500, fontSize: 15),
                          minFontSize: 8,
                          textAlign: TextAlign.center),
                      SizedBox(height: 10),
                      TextFieldWidget(
                          _email,
                          Icon(Icons.email, color: Colors.green),
                          "Correo",
                          false,
                          "Error, campo requerido",
                          TextInputType.emailAddress),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: Constants.buttonPrimary,
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            controllerLogin
                                .recuperarPassword(_email.text.trim())
                                .then((value) => {
                                      print("Valor regresado: " + value),
                                      messageInfromation(
                                          "Informacion",
                                          "Correo enviado para verificacion",
                                          Icon(Icons.email_outlined),
                                          Colors.green),
                                      Get.back()
                                    })
                                .catchError((onError) {
                              if (onError == "user-not-found") {
                                messageInfromation(
                                    "Ups!",
                                    "Este Correo no se encuentra registrado.",
                                    Icon(Icons.email_outlined),
                                    Colors.red);
                              } else if(onError == "invalid-email") {
                                messageInfromation(
                                    "Ups!",
                                    "Digita un correo valido.",
                                    Icon(Icons.email_outlined),
                                    Colors.red);
                              }

                            });
                          }
                          _formkey.currentState?.reset();
                          setState(() {
                            _email.clear();
                          });
                        },
                        child: const Text('Registrar'),
                      ),
                    ],
                  ),
                ))));
  }

  Widget TextFieldWidget(
      TextEditingController controlador,
      icon,
      String textGuide,
      bool estate,
      String msgError,
      TextInputType textInputType) {
    return TextFormField(
        controller: controlador,
        keyboardType: textInputType,
        obscureText: estate,
        decoration: InputDecoration(
          prefixIcon: icon,
          fillColor: Colors.grey.shade300,
          filled: true,
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.green)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          hintText: textGuide,
          labelStyle: TextStyle(color: Colors.green),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return msgError;
          }
        },
        cursorColor: Colors.green);
  }

  void messageInfromation(
      String titulo, String mensaje, Icon icono, Color color) {
    Get.showSnackbar(GetSnackBar(
      title: titulo,
      message: mensaje,
      icon: icono,
      duration: Duration(seconds: 4),
      backgroundColor: color,
    ));
  }
}
