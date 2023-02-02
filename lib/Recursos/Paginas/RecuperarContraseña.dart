import 'package:app_turismo/Recursos/Constants/Constans.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RecuperarContrasena extends StatefulWidget {
  RecuperarContrasena({Key? key}) : super(key: key);

  @override
  State<RecuperarContrasena> createState() => _RecuperarContrasenaState();
}

class _RecuperarContrasenaState extends State<RecuperarContrasena> {
  TextEditingController _email = TextEditingController();

  final _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [ImagenLogo(), FormRecuperarContrasena()],
        ),
      ),
    );
  }

  Widget ImagenLogo() {
    return SafeArea(
      child: Image.asset(
        'assets/img/Logo.png',
        width: 250,
        height: 250,
      ),
    );
  }

  Widget FormRecuperarContrasena() {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 8,
        shadowColor: Colors.black,
        child: Form(
          child: Container(
            margin: const EdgeInsets.fromLTRB(30, 15, 30, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Recuperar Contraseña',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.green,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("Digite email para recuperar contraseña",
                    style: TextStyle(color: Colors.grey.shade500)),
                SizedBox(height: 15),
                TextFieldWidget(
                    _email,
                    FaIcon(
                      FontAwesomeIcons.envelope,
                      color: Colors.green,
                    ),
                    "Digite el correo electronico",
                    false,
                    "Error, compruebe correo.",
                    TextInputType.emailAddress),
                SizedBox(height: 30),
                ElevatedButton(
                    style: Constants.buttonPrimary,
                    onPressed: () {},
                    child: Text('Enviar'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget TextFieldWidget(
      TextEditingController controlador,
      FaIcon icono,
      String textGuide,
      bool estate,
      String msgError,
      TextInputType textInputType) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: TextFormField(
          controller: controlador,
          keyboardType: textInputType,
          obscureText: estate,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: icono,
            ),
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: textGuide,
            labelStyle: TextStyle(color: Colors.green),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return msgError;
            }
          },
          cursorColor: Colors.green),
    );
  }
}
