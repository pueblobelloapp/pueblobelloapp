import 'package:app_turismo/Recursos/Constants/Constans.dart';
import 'package:app_turismo/Recursos/Controller/LoginController.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Registrar extends StatefulWidget {
  Registrar({Key? key}) : super(key: key);

  @override
  State<Registrar> createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  TextEditingController _email = TextEditingController();
  TextEditingController _passwordL = TextEditingController();
  TextEditingController _passwordConfirmada = TextEditingController();
  ControllerLogin controllerLogin = Get.find();

  final _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [ImagenLogo(), FormRegister()])));
  }

  Widget ImagenLogo() {
    return Image.asset(
      'assets/img/Logo.png',
      width: 250,
      height: 250,
    );
  }

  Widget FormRegister() {
    return Padding(
        padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 8,
            shadowColor: Colors.black,
            child: Form(
                key: _formkey,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Registro",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.green,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text("Digite datos para registrarse",
                          style: TextStyle(color: Colors.grey.shade500)),
                      SizedBox(height: 10),
                      TextFieldWidget(
                          _email,
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
                      SizedBox(height: 20),
                      TextFieldWidget(
                          _passwordConfirmada,
                          FaIcon(
                            FontAwesomeIcons.lock,
                            color: Colors.green,
                          ),
                          "Confirmar contraseña",
                          true,
                          "Error, digite una contraseña",
                          TextInputType.text),
                      SizedBox(height: 30),
                      ElevatedButton(
                        style: Constants.buttonPrimary,
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            if (_passwordL.text == _passwordConfirmada.text) {
                              signUp(_email.text, _passwordL.text);
                            }
                          }
                        },
                        child: const Text('Registrar'),
                      ),
                    ],
                  ),
                ))));
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

  void signUp(String email, String password) async {
    CircularProgressIndicator();
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {});
    }
  }

  Future<void> postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _auth.currentUser;
    final ref = firebaseFirestore.doc('propietario/${user!.uid}');

    await ref.set(
        ({'rool': 'Propietario', 'correo': user.email, 'uid': user.uid}),
        SetOptions(merge: false));

    Get.showSnackbar(const GetSnackBar(
      title: 'Validacion de Usuarios',
      message:
      'Registro exitoso.',
      icon: Icon(Icons.person_add),
      duration: Duration(seconds: 4),
      backgroundColor: Colors.green,
    ));

  }
}
