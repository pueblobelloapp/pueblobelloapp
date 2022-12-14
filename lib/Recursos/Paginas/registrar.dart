import 'package:flutter/material.dart';

class Registrar extends StatefulWidget {
  Registrar({Key? key}) : super(key: key);

  @override
  State<Registrar> createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFF7DA453),
      appBar: AppBar(
        backgroundColor: Color(0xFF7DA453),
        leading: IconButton(
            onPressed: () {
              /*  Navigator.push(
                 context, MaterialPageRoute(builder: (context) => LoginF()));*/
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
          'Registrar',
          style: TextStyle(
              fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),
        )),
      ),
      body: Container(
          width: double.infinity,
          //height: 500.0,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromRGBO(125, 164, 83, 9.0),
            Color.fromRGBO(242, 238, 237, 0.0)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Center(
                  child: Container(
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/img/perfil.png'),
                      radius: 90.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Column(
                  children: [
                    Form(
                        child: Container(
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.green, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Column(
                          children: <Widget>[
                            //nombre
                            Row(
                              children: [
                                Text('Nombre',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  // border:Border.all(color: Colors.green, width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: TextFormField(
                                //controller: _nombreF,
                                keyboardType: TextInputType.name,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                cursorColor: Colors.green.shade300,
                                decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(16.0),
                                    fillColor: Colors.white,
                                    hintText: 'Nombre',
                                    hintStyle: TextStyle(color: Colors.black26),
                                    prefixIcon: Image(
                                      image: AssetImage(
                                          'assets/icons/iconsAfrican2.png'),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            //correo
                            Row(
                              children: [
                                Text('Correo',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  //border: Border.all(color: Colors.green, width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: TextFormField(
                                //controller: _nombreF,
                                keyboardType: TextInputType.emailAddress,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                cursorColor: Colors.green.shade300,
                                decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(16.0),
                                    fillColor: Colors.white,
                                    hintText: 'Correo',
                                    hintStyle: TextStyle(color: Colors.black26),
                                    prefixIcon: Image(
                                      image: AssetImage(
                                          'assets/icons/iconsEmail.png'),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            //contraseña
                            Row(
                              children: [
                                Text('Contraseña',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                 /* border:
                                      Border.all(color: Colors.green, width: 2),*/
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: TextFormField(
                                //controller: _nombreF,
                                obscureText: true,
                                //keyboardType: TextInputType.,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                cursorColor: Colors.green.shade300,
                                decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(16.0),
                                    fillColor: Colors.white,
                                    hintText: 'Contraseña',
                                    hintStyle: TextStyle(color: Colors.black26),
                                    prefixIcon: Image(
                                        image: AssetImage(
                                            'assets/icons/iconsContrasena.png'))),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            //sexo y edad
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text('Sexo',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold)),
                                Text('Edad',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            // textFormfield sexo y edad
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                        /*  border: Border.all(
                                              color: Colors.green, width: 2),*/
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      child: TextFormField(
                                        //controller: _sexoR,
                                        keyboardType: TextInputType.name,
                                        cursorColor: Colors.green.shade300,
                                        decoration: InputDecoration(
                                            focusedBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.all(16.0),
                                            fillColor: Colors.white,
                                            hintText: 'Sexo',
                                            hintStyle: TextStyle(
                                                color: Colors.black26),
                                            prefixIcon: Image(
                                              image: AssetImage(
                                                  'assets/icons/iconsSexo.png'),
                                            )),
                                      )
                                      //_inputSexo(),
                                      ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                         /* border: Border.all(
                                              color: Colors.green, width: 2)*/
                                              ),
                                      child: TextFormField(
                                        //controller: _edadR,
                                        keyboardType: TextInputType.number,
                                        cursorColor: Colors.green.shade300,
                                        decoration: InputDecoration(
                                            focusedBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.all(16.0),
                                            fillColor: Colors.white,
                                            hintText: 'Edad',
                                            hintStyle: TextStyle(
                                                color: Colors.black26),
                                            prefixIcon: Image(
                                                image: AssetImage(
                                                    'assets/icons/iconsAge.png'))
                                            //hintStyle: TextStyle(color: Colors.grey.shade300),
                                            ),
                                      )),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            //Telefono
                            Row(
                              children: [
                                Text(
                                  'Telefono',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                /*  border:
                                      Border.all(color: Colors.green, width: 2),*/
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: TextFormField(
                                //controller: _nombreF,
                                keyboardType: TextInputType.number,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                cursorColor: Colors.green.shade300,
                                decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(16.0),
                                    fillColor: Colors.white,
                                    hintText: 'Telefono',
                                    hintStyle: TextStyle(color: Colors.black26),
                                    prefixIcon: Image(
                                      image: AssetImage(
                                          'assets/icons/iconsWhatsapp.png'),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            //boton guardar
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      primary: Color(0xFFAED581),
                                      onPrimary: Colors.black,
                                    //  side: BorderSide(color: Color(0xFF7DA453), width: 2),
                                      elevation: 5.0,
                                    ),
                                    onPressed: () {},
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30.0, vertical: 12.0),
                                        child: Text(
                                          'Guardar',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold),
                                        )))
                              ],
                            )
                          ],
                        ),
                      ),
                    ))
                  ],
                )
              ],
            ),
          )),
    );
  }
}
