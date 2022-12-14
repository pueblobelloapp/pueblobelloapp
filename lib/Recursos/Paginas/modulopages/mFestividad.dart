// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Mfestividad extends StatefulWidget {
  Mfestividad({Key? key}) : super(key: key);

  @override
  State<Mfestividad> createState() => _MfestividadState();
}

class _MfestividadState extends State<Mfestividad> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0E0E0),
      appBar: AppBar(
        backgroundColor: Color(0xFF7DA453),
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
            )),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                // Navigator.of(context).pop(Menu());
              },
              icon: Icon(
                Icons.output_sharp,
                color: Colors.black,
              ))
        ],
        title: Align(
          child: Text(
            'Módulo de Festividad',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          alignment: Alignment.center,
        ),
      ),
      body: SingleChildScrollView(child: Formulario()),
    );
  }

  Widget Formulario() {
    final _nombreF = TextEditingController();
    String _tipoTurismo = "";
    //File imagenF;
    final _capacidadF = TextEditingController();
    final _ubicacionF = TextEditingController();
    final _descripcionF = TextEditingController();

    final lista = ["Cultural", "Rural", "Ecoturismo", "Bienestar"];

    return Container(
      padding: EdgeInsets.all(16.0),
      child: Form(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            //Nombre
            Row(
              children: [
                Text(
                  'Nombre',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 4.0,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    /*  border: Border.all(
                        color: Colors.green,
                        width: 2,
                      ),*/
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: TextFormField(
                      controller: _nombreF,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.sentences,
                      cursorColor: Colors.green.shade300,
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16.0),
                          fillColor: Colors.white,
                          hintText: 'Nombre de la Festividad',
                          hintStyle: TextStyle(color: Colors.grey.shade300),
                          prefixIcon: Image(
                            image: AssetImage('assets/icons/iconsFiesta2.png'),
                          )
                          /*const Icon(
                            Icons.home_rounded,
                            color: Colors.blue,
                          )*/
                          ),
                      validator: (Value) {
                        if (Value!.isEmpty) {
                          return "Digite el nombre de la festividad";
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            //button imagen
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(5.0),
                  height: 34.0,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        primary: Color(0xFFFFFFFF),
                        onPrimary: Colors.black,
                      /*  side: BorderSide(
                            color: Color(
                              0xFF7DA453,
                            ),
                            width: 2),*/
                        elevation: 5.0,
                      ),
                      child: Row(
                        children: [
                          Image(
                            image: AssetImage('assets/icons/iconsImagen.png'),
                            height: 24,
                            width: 24,
                          ),
                          SizedBox(width: 2),
                          Text('Imagen')
                        ],
                      ),
                      onPressed: () {
                        opciones(context);
                      } /* async {
                      final ImagePicker _picker = ImagePicker();
                      PickedFile? _pickedFile =
                          await _picker.getImage(source: ImageSource.gallery);
                    },*/
                      ),
                ),
                //caja imagen
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                 /*   border: Border.all(
                      color: Colors.green,
                      width: 2,
                    ),*/
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  /* child: (imagePath == null)
                      ? Container()
                      : Image.file(File(imagePath)),*/
                  child: TextFormField(
                    //maxLines: 2,
                    //controller: controlUser,
                    //keyboardType: TextInputType.name,
                    cursorColor: Colors.green.shade300,
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16.0),
                      fillColor: Colors.white,
                      hintText: 'Seleccione una imagen...',
                      hintStyle: TextStyle(color: Colors.grey.shade300),
                    ),
                  ),
                ))
              ],
            ),
            SizedBox(
              height: 14.0,
            ),
            // tipo de festividad
            Row(
              children: [
                Text(
                  'Tipo de Festividad',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 4.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              /*  border: Border.all(
                  color: Colors.green,
                  width: 2,
                ),*/
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: DropdownButtonFormField<String>(
                  //controller: controlUser,
                  //keyboardType: TextInputType.name,
                  // cursorColor: Colors.green.shade300,
                  decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16.0),
                      //fillColor: Colors.white,
                      prefixIcon: Image(
                          image: AssetImage('assets/icons/iconsLista.png'))),
                  isExpanded: true,
                  items: lista.map((lista) {
                    return DropdownMenuItem(
                        value: lista, child: Text('Turismo $lista'));
                  }).toList(),
                  onChanged: ((value) => setState(() {
                        _tipoTurismo = "Turismo";
                        _tipoTurismo += value!;
                        print(_tipoTurismo);
                      })),
                  hint: Text(
                    'Seleccione un tipo de Festividad',
                    style: TextStyle(color: Colors.grey.shade300),
                  )),
            ),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            //button ubicación
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      primary: Color(0xFFFFFFFF),
                      onPrimary: Colors.black,
                     /* side: BorderSide(
                          color: Color(
                            0xFF7DA453,
                          ),
                          width: 2),*/
                      elevation: 5.0,
                    ),
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage('assets/icons/iconsUbicacion.png'),
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(width: 2),
                        Text('Ubicación')
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    /*  border: Border.all(
                        color: Colors.green,
                        width: 2,
                      ),*/
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: TextFormField(
                      //controller: _ubicacionF,
                      //keyboardType: TextInputType.number,
                      cursorColor: Colors.green.shade300,
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16.0),
                        fillColor: Colors.white,
                        hintText: 'Ubicación no encontrada',
                        hintStyle: TextStyle(color: Colors.grey.shade300),
                        /* prefixIcon: const Icon(
                              Icons.account_circle_rounded,
                              color: Colors.black,
                            )*/
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 14.0,
            ),
            //descripción
            Row(
              children: [
                Text(
                  'Descripción',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 4.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              /*  border: Border.all(
                  color: Colors.green,
                  width: 2,
                ),*/
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: TextFormField(
                maxLines: 5,
                controller: _descripcionF,
                cursorColor: Colors.green.shade300,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16.0),
                  fillColor: Colors.white,
                  hintText: 'Realize una pequeña descripción de la Festividad',
                  hintStyle: TextStyle(color: Colors.grey.shade300),
                ),
                validator: (value) {
                  if (value!.isEmpty) return "Digite una descripcion ";
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('100 caracteres',
                    style: TextStyle(color: Colors.grey.shade400))
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            //button guardar
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      primary: Color(0xFFAED581),
                      onPrimary: Colors.black,
                    /*  side: BorderSide(
                          color: Color(
                            0xFF7DA453,
                          ),
                          width: 2),*/
                      elevation: 5.0,
                    ),
                    onPressed: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 12.0),
                      child: Text(
                        'Guardar',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  opciones(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            contentPadding: EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        final ImagePicker _picker = ImagePicker();
                        PickedFile? _pickedFile =
                            await _picker.getImage(source: ImageSource.camera);
                      },
                      child: Container(
                        padding: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                           // border: Border.all(color: Colors.green, width: 2),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            )),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Cámara',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Image(
                                image:
                                    AssetImage('assets/icons/iconsCamara.png'))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    InkWell(
                      onTap: () async {
                        final ImagePicker _picker = ImagePicker();
                        PickedFile? _pickedFile =
                            await _picker.getImage(source: ImageSource.gallery);
                      },
                      child: Container(
                        padding: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                           // border: Border.all(color: Colors.green, width: 2),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            )),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Galería de Imágenes',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Image(
                              image:
                                  AssetImage('assets/icons/iconsGaleria.png'),
                              height: 24,
                              width: 24,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                            color: Colors.red,
                           // border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            )),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Cancelar',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
