import 'package:app_turismo/Recursos/Paginas/login.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/mCultura.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/mFestividad.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/mGastronom%C3%ADa.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/mPropietario.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/mReligion.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/mSitiosTuristico.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color(0xFFDADADA),
        //appBar
        appBar: AppBar(
          backgroundColor: Color(0xFF7DA453),
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => LoginF()));
              },
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
              )),
          actions: <Widget>[
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.output_sharp,
                  color: Colors.black,
                )),
          ],
          title: Align(
            child: Text(
              'Turismo App',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            alignment: Alignment.center,
          ),
        ),
        // contenido del menu
        body: Container(
          // width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromRGBO(125, 164, 83, 9.0),
            Color.fromRGBO(242, 238, 237, 0.0)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          child: ListView(
            //shrinkWrap: true,
            padding: const EdgeInsets.all(10.0),
            children: <Widget>[
              //Modulo sitios turistico
              ListTile(
                title: Text(
                  'Gesti??n del m??dulo de sitios tur??stico',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Image(
                  image: AssetImage('assets/icons/iconsMapa.png'),
                  height: 40,
                  width: 40,
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MsitiosTuristico()));
                },
              ),
              Divider(
                color: Colors.green,
              ),
              //Modulo Cultura
              ListTile(
                title: Text(
                  'Gesti??n del m??dulo de cultra',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Image(
                  image: AssetImage('assets/icons/iconsAfrican.png'),
                  height: 40,
                  width: 40,
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Mcultura()));
                },
              ),
              Divider(
                color: Colors.green,
              ),
              //Modulo de gastronom??a
              ListTile(
                title: Text(
                  'Gesti??n del m??dulo de gastronom??a',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Image(
                  image: AssetImage('assets/icons/iconsEnsalada.png'),
                  height: 40,
                  width: 40,
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Mgastronomia()));
                },
              ),
              Divider(
                color: Colors.green,
              ),
              //Modulo festividad
              ListTile(
                title: Text(
                  'Gesti??n del m??dulo de festividad',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Image(
                  image: AssetImage('assets/icons/iconsFiesta.png'),
                  height: 40,
                  width: 40,
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Mfestividad()));
                },
              ),
              Divider(
                color: Colors.green,
              ),
              //Modulo propietarios
              ListTile(
                title: Text(
                  'Gesti??n del m??dulo de propietarios',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Image(
                  image: AssetImage('assets/icons/iconsAdmin.png'),
                  height: 40,
                  width: 40,
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Mpropietario()));
                },
              ),
              Divider(
                color: Colors.green,
              ),
              //Modulo religi??n
              ListTile(
                title: Text(
                  'Gesti??n del m??dulo de religi??n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Image(
                  image: AssetImage('assets/icons/iconsReligion.png'),
                  height: 40,
                  width: 40,
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Mreligion()));
                },
              ),
              Divider(
                color: Colors.green,
              ),
            ],
          ),
        ));
  }
}
