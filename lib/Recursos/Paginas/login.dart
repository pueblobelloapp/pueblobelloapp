// ignore_for_file: unnecessary_import

import 'package:app_turismo/Recursos/Paginas/menu.dart';
import 'package:app_turismo/Recursos/Paginas/registrar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginF extends StatefulWidget {
  LoginF({Key? key}) : super(key: key);

  @override
  State<LoginF> createState() => _LoginFState();
}

class _LoginFState extends State<LoginF> {
  TextEditingController _userL = TextEditingController();
  TextEditingController _passwordL = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        FondoApp(),
        ImagenLogo(),
        LoginForm(),
        SizedBox(
          height: 50.0,
        ),
      ],
    ));
  }

  Widget FondoApp() {
    final gradient = Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(125, 164, 83, 9.0),
        Color.fromRGBO(242, 238, 237, 0.0)
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      padding: EdgeInsets.symmetric(vertical: 60.0),
      child: Text(
        'Turismo App',
        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );

    return Stack(
      children: <Widget>[
        gradient,
      ],
    );
  }

  Widget ImagenLogo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: Image.asset(
        'assets/img/Logo.png',
        width: 310,
        height: 430,
      ),
    );
  }

  Widget LoginForm() {
    final Size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
              child: Container(
            height: 290.0,
          )),
          Container(
            width: Size.width * 0.90,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.green, width: 1.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Color(0xFFAED581),
                      blurRadius: 25.0,
                      offset: Offset(.0, 0.0),
                      spreadRadius: 10.0),
                ]),
            child: Column(
              children: <Widget>[
                Text(
                  'Ingreso',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15.0,
                ),
                //input email
                Row(
                  children: [
                    Text(
                      'Email',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                     // border: Border.all(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: TextFormField(
                    controller: _userL,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.green.shade300,
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16.0),
                        fillColor: Colors.white,
                        hintText: 'Ingrese Email',
                        hintStyle: TextStyle(color: Colors.black26),
                        prefixIcon: Image(
                            image: AssetImage('assets/icons/iconsEmail.png'))),
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                //input contraseña
                Row(
                  children: [
                    Text('Contraseña',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold))
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                     // border: Border.all(color: Colors.green, width: 0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: TextFormField(
                    controller: _passwordL,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.green.shade300,
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16.0),
                        fillColor: Colors.white,
                        hintText: 'Ingrese Contraseña',
                        hintStyle: TextStyle(color: Colors.black26),
                        prefixIcon: Image(
                            image: AssetImage(
                                'assets/icons/iconsContrasena.png'))),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                //registrarme y olvido contraseña
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Registrar()));
                      },
                      child: Text(
                        'Registrarme',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        print('OK!');
                      },
                      child: Text(
                        '¿Olvidaste contraseña?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.0,
                ),
                //button iniciar sesión
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        primary: Color(0xFFAED581),
                        onPrimary: Colors.black,
                        //side: BorderSide(color: Color(0xFF7DA453),width: 2),
                        elevation: 5.0,
                      ),
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 15.0),
                          child: Text('Iniciar Sesión',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold))),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Menu()));
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 60.0,
                ),
                //redes sociales
              /*  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        print('OK!');
                      },
                      child: Image(
                          image: AssetImage('assets/icons/iconsFacebook.png')),
                    ),
                    InkWell(
                      onTap: () {
                        print('OK!');
                      },
                      child: Image(
                          image: AssetImage('assets/icons/iconsWhatsapp.png')),
                    ),
                    InkWell(
                      onTap: () {
                        print('OK!');
                      },
                      child: Image(
                          image: AssetImage('assets/icons/iconsInstagram.png')),
                    ),
                  ],
                ),*/
             /*   SizedBox(
                  height: 10.0,
                )*/
              ],
            ),
          ),
        ],
      ),
    );
  }
}
