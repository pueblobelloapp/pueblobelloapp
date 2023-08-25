import 'package:app_turismo/Recursos/Constants/Constans.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GextUtils.dart';
import 'package:app_turismo/Recursos/Controller/LoginController.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/HeaderProfile.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecuperarPassword extends StatefulWidget {
  const RecuperarPassword({Key? key}) : super(key: key);

  @override
  State<RecuperarPassword> createState() => _RecuperarPasswordState();
}

class _RecuperarPasswordState extends State<RecuperarPassword> {
  TextEditingController _email = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  final GetxUtils messageController = Get.put(GetxUtils());
  ControllerLogin controllerLogin = Get.find();

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
                        "Recupera tu cuenta",
                        style: TextStyle(fontSize: 20, color: Colors.black87),
                        maxLines: 2,
                        minFontSize: 18,
                        textAlign: TextAlign.center,
                      ),
                      const Divider(
                        height: 20,
                        thickness: 1,
                        indent: 1,
                        endIndent: 1,
                        color: Colors.grey,
                      ),
                      AutoSizeText(
                        "Ingresa tu correo electronico.",
                        style: TextStyle(fontSize: 20, color: Colors.green),
                        maxLines: 2,
                        minFontSize: 18,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      TextFieldWidget(
                          _email,
                          Icon(Icons.email, color: Colors.green),
                          "Correo",
                          false,
                          "Error, campo requerido",
                          TextInputType.emailAddress),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: Constants.buttonPrimary,
                            onPressed: () {
                              validateEmail();
                            },
                            child: const Text('Buscar'),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            style: Constants.buttonCancel,
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text('Volver'),
                          ),
                        ],
                      )
                    ],
                  ),
                ))));
  }

  void validateEmail() {
    final bool isValidEmail = EmailValidator.validate(_email.text);
    if (_formkey.currentState!.validate() && isValidEmail) {
      controllerLogin
          .recuperarPassword(_email.text.trim())
          .then((value) => {
                messageController.messageWarning(
                    "Recuperacion", "Correo enviado para verificacion"),
                Get.back()
              })
          .catchError((onError) {
        if (onError == "user-not-found") {
          messageController.messageWarning(
              "Correo invalido", "Este Correo no se encuentra registrado.");
        } else if (onError == "invalid-email") {
          messageController.messageWarning(
              "Correo invalido", "Digita un correo valido.");
        }
      });
    } else {
      messageController.messageWarning(
          "Informacion", "Verifique el correo electronico.");
    }
    _formkey.currentState?.reset();
    setState(() {
      _email.clear();
    });
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
}
