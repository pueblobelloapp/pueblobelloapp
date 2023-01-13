// ignore_for_file: unnecessary_import

import 'package:app_turismo/Recursos/Controller/LoginController.dart';
import 'package:app_turismo/Recursos/Paginas/Menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_turismo/Recursos/Constants/Constans.dart';


class LoginF extends StatefulWidget {
  LoginF({Key? key}) : super(key: key);

  @override
  State<LoginF> createState() => _LoginFState();
}

class _LoginFState extends State<LoginF> {
  TextEditingController _userL = TextEditingController();
  TextEditingController _passwordL = TextEditingController();
  ControllerLogin controllerLogin = Get.find();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
                children: [ImagenLogo(), FormLogin(), SocialNetworks()])));
  }

  Widget ImagenLogo() {
    return Image.asset(
      'assets/img/Logo.png',
      width: 300,
      height: 300,
    );
  }

  Widget FormLogin() {
    return Padding(
        padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 8,
            shadowColor: Colors.black,
            child: Form(
                key: _formKey,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Bienvenido",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.green,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text("Digite datos para iniciar sesion",
                          style: TextStyle(color: Colors.grey.shade500)),
                      SizedBox(height: 10),
                      TextFieldWidget(
                          _userL,
                          Icon(Icons.email, color: Colors.green),
                          "Digite correo electronico",
                          false,
                          "Error, compruebe correo.",
                          TextInputType.emailAddress),
                      SizedBox(height: 20),
                      TextFieldWidget(
                          _passwordL,
                          Icon(
                            Icons.password,
                            color: Colors.green,
                          ),
                          "Digite contraseña",
                          true,
                          "Error, digite una contraseña",
                          TextInputType.text),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                //Move to page Register
                              },
                              child: Text("Registrarme",
                                  style: TextStyle(color: Colors.green)),
                            ),
                            TextButton(
                              onPressed: () {
                                //Move to page Recovery password
                              },
                              child: Text("Recuperar contraseña",
                                  style: TextStyle(color: Colors.green)),
                            )
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: Constants.buttonPrimary,
                        onPressed: () {
                          controllerLogin
                              .getLogin(_userL.text, _passwordL.text)
                              .then((value) => {
                                    if (controllerLogin.email !=
                                        "Sin Registro")
                                      {
                                        Get.to(() => MenuModuls())
                                      }
                                    else
                                      {
                                        print("Acceso NEGADO"),
                                        Get.showSnackbar(const GetSnackBar(
                                          title: 'Validacion de Usuarios',
                                          message: 'Error desde la validacion',
                                          icon: Icon(Icons.person_add),
                                          duration: Duration(seconds: 4),
                                          backgroundColor: Colors.red,
                                        ))
                                      }
                                  })
                              .catchError((onerror) {
                            Get.showSnackbar(const GetSnackBar(
                              title: 'Validacion de Usuarios',
                              message: 'Error desde la Excepcion',
                              icon: Icon(Icons.person_add),
                              duration: Duration(seconds: 4),
                              backgroundColor: Colors.red,
                            ));
                          });
                        },
                        child: const Text('Acceder'),
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

  Widget SocialNetworks() {
    return Column(
      children: [
        Text(
          "- O - \n\n Inicia sesion con",
          style: TextStyle(
            color: Colors.grey.shade500,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Image.asset('assets/Icons/google.png', width: 30, height: 30)
      ],
    );
  }
}
