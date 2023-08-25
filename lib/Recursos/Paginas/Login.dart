import 'package:app_turismo/Recursos/Controller/GextControllers/GextUtils.dart';
import 'package:app_turismo/Recursos/Controller/LoginController.dart';
import 'package:app_turismo/Recursos/Paginas/Menu.dart';
import 'package:app_turismo/Recursos/Paginas/Register.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/RecuperarCuenta.dart';
import 'package:app_turismo/Recursos/Constants/Constans.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:core';
import 'package:email_validator/email_validator.dart';

class LoginF extends StatefulWidget {
  LoginF({Key? key}) : super(key: key);

  @override
  State<LoginF> createState() => _LoginFState();
}

class _LoginFState extends State<LoginF> {
  TextEditingController _userL = TextEditingController();
  TextEditingController _passwordL = TextEditingController();

  String mensajeNotification = "Error";
  bool isLoading = false;

  ControllerLogin controllerLogin = Get.find();
  final GetxUtils messageController = Get.put(GetxUtils());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [ImagenLogo(), FormLogin(), OptionSesion()])));
  }

  Widget ImagenLogo() {
    return SafeArea(
        child: Image.asset(
      'assets/img/Logo.png',
      width: 250,
      height: 250,
    ));
  }

  Widget FormLogin() {
    return Padding(
        padding: EdgeInsets.fromLTRB(25, 0, 25, 5),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 8,
            shadowColor: Colors.black,
            child: Form(
                key: _formKey,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(15, 20, 15, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Bienvenido",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.green,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      TextFieldWidget(
                          _userL,
                          FaIcon(
                            FontAwesomeIcons.envelope,
                            color: Colors.green,
                          ),
                          "Digite correo electronico",
                          false,
                          "Error, compruebe correo.",
                          TextInputType.emailAddress),
                      SizedBox(height: 20),
                      TextFieldWidget(
                          _passwordL,
                          FaIcon(
                            FontAwesomeIcons.lock,
                            color: Colors.green,
                          ),
                          "Digite contraseña",
                          true,
                          "Error, digite una contraseña",
                          TextInputType.text),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () {
                                  //Move to page Recovery password
                                  Get.to(() => RecuperarPassword());
                                },
                                child: AutoSizeText(
                                  "¿Olvidaste tu conatraseña?",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.green),
                                  maxLines: 2,
                                ))
                          ],
                        ),
                      ),
                      ElevatedButton(
                          style: Constants.buttonPrimary,
                          onPressed: () {
                            validateLogin();
                          },
                          child: isLoading
                              ? Center(
                                  child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 20.0,
                                      width: 20.0,
                                      child: CircularProgressIndicator(
                                          color: Colors.white),
                                    ),
                                    SizedBox(width: 10.5),
                                    Text("Iniciando sesion")
                                  ],
                                ))
                              : Center(child: Text("Acceder"))),
                    ],
                  ),
                ))));
  }

  void validateLogin() {
    final bool isValid = EmailValidator.validate(_userL.text);

    if (_formKey.currentState!.validate() && isValid) {
      setState(() {
        isLoading = true;
      });

      controllerLogin
          .getLogin(_userL.text, _passwordL.text)
          .then((value) => {
                if (controllerLogin.email != "Sin Registro" &&
                    controllerLogin.userRole != "")
                  {
                    print(controllerLogin.dataUsuario.toString()),
                    Get.to(() => MenuModuls())
                  }
                else
                  {
                    print(controllerLogin.dataUsuario.toString()),
                    messageController.messageWarning(
                        "Usuario", "No te encuentras registrado"),
                  }
              })
          .catchError((onerror) {
        if (onerror == "wrong-password") {
          mensajeNotification = "Contraseña incorrecta";
        } else if (onerror == "user-not-found") {
          mensajeNotification = "Email no existe.";
        } else if (onerror == "network-request-failed") {
          mensajeNotification = "No pudimos consultar tu usuario.";
        } else {
          mensajeNotification = onerror.toString();
        }

        setState(() {
          isLoading = false;
        });
        print("Errpr: " + onerror.toString());
        messageController.messageError("Validacion", mensajeNotification);
      });
    } else {
      messageController.messageWarning("Validacion", "Compruebe los datos");
    }
  }

  Widget TextFieldWidget(
      TextEditingController controlador,
      FaIcon icono,
      String textGuide,
      bool estate,
      String msgError,
      TextInputType textInputType) {
    return TextFormField(
        controller: controlador,
        keyboardType: textInputType,
        obscureText: estate,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: icono,
          ),
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

  Widget OptionSesion() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "No tienes una cuenta?",
              style: TextStyle(
                color: Colors.grey.shade500,
              ),
              textAlign: TextAlign.center,
            ),
            TextButton(
                onPressed: () {
                  Get.to(() => Registrar());
                },
                child: Text(
                  "Crear cuenta",
                  style: TextStyle(color: Colors.green),
                ))
          ],
        )
      ],
    );
  }
}
