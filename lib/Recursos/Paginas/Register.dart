import 'package:app_turismo/Recursos/Constants/Constans.dart';
import 'package:app_turismo/Recursos/Controller/LoginController.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/HeaderProfile.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Registrar extends StatefulWidget {
  Registrar({Key? key}) : super(key: key);

  @override
  State<Registrar> createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  TextEditingController _nombre = TextEditingController();
  TextEditingController _contacto = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _passwordL = TextEditingController();
  TextEditingController _passwordConfirmada = TextEditingController();
  ControllerLogin controllerLogin = Get.find();

  final _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [HeaderImage(), SizedBox(height: 30), FormRegister()],
        )));
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
                      Text("Crear cuenta",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.green,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text("Digite datos para registrarse",
                          style: TextStyle(color: Colors.grey.shade500)),
                      SizedBox(height: 10),
                      TextFieldWidget(
                          _nombre,
                          Icon(Icons.person, color: Colors.green),
                          "Nombre",
                          false,
                          "Error, campo requerido",
                          TextInputType.text),
                      SizedBox(height: 10),
                      TextFieldWidget(
                          _contacto,
                          Icon(Icons.phone, color: Colors.green),
                          "Numero contacto",
                          false,
                          "Error, campo requerido",
                          TextInputType.number),
                      SizedBox(height: 10),
                      TextFieldWidget(
                          _email,
                          Icon(Icons.email, color: Colors.green),
                          "Correo electronico",
                          false,
                          "Error, campo requerido.",
                          TextInputType.emailAddress),
                      SizedBox(height: 10),
                      TextFieldWidget(
                          _passwordL,
                          Icon(
                            Icons.password,
                            color: Colors.green,
                          ),
                          "Contraseña",
                          true,
                          "Error, digite una contraseña",
                          TextInputType.text),
                      SizedBox(height: 10),
                      TextFieldWidget(
                          _passwordConfirmada,
                          Icon(
                            Icons.password,
                            color: Colors.green,
                          ),
                          "Confirmar contraseña",
                          true,
                          "Error, digite una contraseña",
                          TextInputType.text),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: Constants.buttonPrimary,
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            if (_passwordL.text == _passwordConfirmada.text) {
                              signUp(_email.text, _passwordL.text, _nombre.text,
                                  _contacto.text);

                            } else {
                              messageInfromation(
                                  "Validacion campos",
                                  "Las contraseñas no coinciden.",
                                  Icon(Icons.password), Colors.red);
                            }
                          }
                          _formkey.currentState?.reset();
                          setState(() {
                            _nombre.clear();
                            _contacto.clear();
                            _email.clear();
                            _passwordL.clear();
                            _passwordConfirmada.clear();
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

  void signUp(
      String email, String password, String nombre, String contacto) async {
    CircularProgressIndicator();
    if (_formkey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore(nombre, contacto)});
      } on FirebaseException catch (e) {
        if (e.code == "email-already-in-use") {
          messageInfromation("Validacion datos",
              "El correo se encuentra registrado", Icon(Icons.email_outlined), Colors.red);
        }
      }
    }
  }

  void messageInfromation(String titulo, String mensaje, Icon icono, Color color) {
    Get.showSnackbar(GetSnackBar(
      title: titulo,
      message: mensaje,
      icon: icono,
      duration: Duration(seconds: 4),
      backgroundColor: color,
    ));
  }

  Future<void> postDetailsToFirestore(String nombre, String contacto) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _auth.currentUser;
    final ref = firebaseFirestore.doc('propietario/${user!.uid}');

    await ref.set(
        ({
          'uid': user.uid,
          'rool': 'Propietario',
          'nombre': nombre,
          'edad': '0',
          'genero': 'Sin Definir',
          'correo': user.email,
          'contacto': contacto
        }),
        SetOptions(merge: false));

    messageInfromation(
        "Informacion Registro",
        "Se registro correctamente.",
        Icon(Icons.person_add), Colors.lightGreen);
  }
}
