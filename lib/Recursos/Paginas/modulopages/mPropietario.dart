import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Mpropietario extends StatefulWidget {
  Mpropietario({Key? key}) : super(key: key);

  @override
  State<Mpropietario> createState() => _MpropietarioState();
}

enum TipoCharacter { Masculino, Femenino }

class _MpropietarioState extends State<Mpropietario> {
  TipoCharacter? _tipoGenero = TipoCharacter.Masculino;

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
              )),
        ],
        title: Align(
          child: Text(
            ' Módulo de propietarios',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          alignment: Alignment.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Formulario(),
      ),
    );
  }

  Widget Formulario() {
    final _nombreP = TextEditingController();
    final _sitioTuristicoP = TextEditingController();
    //File imagenR;
    final _correoP = TextEditingController();
    final _edadP = TextEditingController();
    final _contactoP = TextEditingController();

    return Container(
      padding: EdgeInsets.all(16.0),
      child: Form(
          child: Column(
        children: <Widget>[
          //nombre
          Row(children: [
            Text(
              'Nombre',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ]),
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
                    controller: _nombreP,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.sentences,
                    cursorColor: Colors.green.shade300,
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16.0),
                        fillColor: Colors.white,
                        hintText: 'Nombre del propietario',
                        hintStyle: TextStyle(color: Colors.grey.shade300),
                        prefixIcon: Image(
                          image: AssetImage('assets/icons/iconsAfrican2.png'),
                        )
                        /*const Icon(
                            Icons.home_rounded,
                            color: Colors.blue,
                          )*/
                        ),
                    validator: (Value) {
                      if (Value!.isEmpty) {
                        return "Digite el nombre del sitio turistico";
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
          //sito turistico
          Row(
            children: [
              Text(
                'Sitio Turístico',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
              )
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
                    controller: _sitioTuristicoP,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.sentences,
                    cursorColor: Colors.green.shade300,
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16.0),
                        fillColor: Colors.white,
                        hintText: 'Nombre del sitio turístico',
                        hintStyle: TextStyle(color: Colors.grey.shade300),
                        prefixIcon: Image(
                          image: AssetImage('assets/icons/iconsCasa.png'),
                        )
                        /*const Icon(
                            Icons.home_rounded,
                            color: Colors.blue,
                          )*/
                        ),
                    validator: (Value) {
                      if (Value!.isEmpty) {
                        return "Digite el nombre del sitio turistico";
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 18.0,
          ),
          //Imagen
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
                    }),
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
            height: 15.0,
          ),
          //edad y genero
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'Edad',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
              ),
              Text(
                'Género',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
              )
            ],
          ),
          //textformfiel edad y genero
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        //border: Border.all(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: TextFormField(
                      //controller: _edadP,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.green.shade300,
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16.0),
                        fillColor: Colors.white,
                        hintText: 'Edad',
                        hintStyle: TextStyle(color: Colors.grey.shade300),
                      ),
                    )),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Row(
                    children: [
                      Column(children: [
                        Row(
                          children: [
                            Radio<TipoCharacter>(
                                value: TipoCharacter.Masculino,
                                groupValue: _tipoGenero,
                                onChanged: (TipoCharacter? value) =>
                                    setState(() {
                                      _tipoGenero = value;
                                    })),
                            Text(
                              'Masculino',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio<TipoCharacter>(
                                value: TipoCharacter.Femenino,
                                groupValue: _tipoGenero,
                                onChanged: (TipoCharacter? value) =>
                                    setState(() {
                                      _tipoGenero = value;
                                    })),
                            Text(
                              'Femenino',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ]),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 14.0,
          ),
          //correo
          Row(
            children: [
              Text(
                'Correo',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
              )
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
                       /* border: Border.all(
                          color: Colors.green,
                          width: 2,
                        ),*/
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: TextFormField(
                      controller: _correoP,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.green.shade300,
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16.0),
                          fillColor: Colors.white,
                          hintText: 'Correo electronico o email',
                          hintStyle: TextStyle(color: Colors.grey.shade300),
                          prefixIcon: Image(
                            image: AssetImage('assets/icons/iconsEmail.png'),
                          )),
                      validator: (Value) {
                        if (Value!.isEmpty) {
                          return "Digite el email";
                        }
                      },
                    )),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          //contacto
          Row(
            children: [
              Text(
                'Contacto',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
              )
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
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: TextFormField(
                  controller: _contactoP,
                  cursorColor: Colors.green.shade300,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16.0),
                      fillColor: Colors.white,
                      hintText: 'Teléfono',
                      hintStyle: TextStyle(color: Colors.grey.shade300),
                      prefixIcon: Image(
                        image: AssetImage('assets/icons/iconsWhatsapp.png'),
                      )),
                  validator: (Value) {
                    if (Value!.isEmpty) {
                      return "Digite el número de teléfono";
                    }
                  },
                ),
              )),
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
                  /*  side: BorderSide(color: Color(0xFF7DA453,),
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
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                      )))
            ],
          )
        ],
      )),
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
                          //  border: Border.all(color: Colors.green, width: 2),
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
                            //Icon(Icons.image_outlined)
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
                          //  border: Border.all(color: Colors.black, width: 2),
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
