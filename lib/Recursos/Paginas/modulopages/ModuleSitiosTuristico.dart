import 'package:app_turismo/Recursos/Controller/GextControllers/GetxSitioTuristico.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GexTurismo.dart';
import 'package:app_turismo/Recursos/Controller/SitesController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

class ModuleSitiosTuristicos extends StatelessWidget {
  final GetxSitioTuristico _controllerGetxTurismo =
      Get.put(GetxSitioTuristico());

  final _nombreST = TextEditingController();
  final _tipoTurismo = TextEditingController();
  final _capacidadST = TextEditingController();
  final _descripcionST = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _ubicacionST = "";
  String _uidUser = "";
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {

    final editControlTurismo = Get.find<GextControllerTurismo>();
    _uidUser = editControlTurismo.uidUser;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        reverse: true,
        child: Formulario(),
      ),
    );
  }

  Widget Formulario() {
    final listTypeTravel = ["Cultural", "Rural", "Ecoturismo", "Bienestar"];
    List<XFile>? images = [];
    List<dynamic>? fotografias = [];

    _nombreST.text = _controllerGetxTurismo.nombre;
    _descripcionST.text = _controllerGetxTurismo.descripcion;
    _capacidadST.text = _controllerGetxTurismo.capacidad;
    _ubicacionST = _controllerGetxTurismo.ubicacion;
    _tipoTurismo.text = _controllerGetxTurismo.tipoTurismo;
    fotografias = _controllerGetxTurismo.fotoUrl;
    final editControlSitioTurismo = Get.find<GetxSitioTuristico>();

    print("Turismo: " + _controllerGetxTurismo.tipoTurismo);

    return Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Nombre",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                textForm(
                    _nombreST, "Nombre sitio turistico", 1, TextInputType.name),
                SizedBox(height: 15),
                Text("Tipo de turismo",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                ListTravel(_tipoTurismo, listTypeTravel),
                SizedBox(height: 15),
                Text("Capacidad personas",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                textForm(
                    _capacidadST, "Cantidad personas", 1, TextInputType.number),
                SizedBox(height: 15),
                Text("Descripcion",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                textForm(_descripcionST, "Descripcion del sitio", 5,
                    TextInputType.name),
                SizedBox(height: 15),
                Text("Carga de fotografias",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextButton.icon(
                    onPressed: () async {

                      images = await _picker.pickMultiImage();

                      final List<XFile>? selectedImages = await
                      _picker.pickMultiImage();
                      if (selectedImages!.isNotEmpty) {
                        images!.addAll(selectedImages);
                        editControlSitioTurismo.updateFilesImage(selectedImages);
                        messageInformation("Fotografia",
                            "${selectedImages.length.toString()} " +
                                "fotografias seleccionadas",
                            Icon(Icons.image_outlined),
                            Colors.deepOrangeAccent);
                      } else {
                        messageInformation("Fotografia",
                            "Ups! no pudimos seleccionar las fotos",
                            Icon(Icons.image_outlined),
                            Colors.deepOrangeAccent);
                      }
                    },
                    icon: Icon(
                      Icons.photo,
                      color: Colors.green,
                    ),
                    label: Text(
                      "Seleccionar",
                      style: TextStyle(color: Colors.green),
                    )),
                Text("Ubicacion geografica",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                GetBuilder<GetxSitioTuristico>(
                  init: GetxSitioTuristico(),
                  builder: (controller) {
                    return Text('${controller.ubicacion}');
                  },
                ),
                TextButton.icon(
                    onPressed: () {
                      _getCurrentLocation();
                    },
                    icon: Icon(
                      Icons.location_on,
                      color: Colors.green,
                    ),
                    label: Text(
                      "Ubicar",
                      style: TextStyle(color: Colors.green),
                    )),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        final editController = Get.find<EditSitesController>();

                        if (_formKey.currentState!.validate() &&
                            _ubicacionST.isEmpty) {
                          Get.showSnackbar(const GetSnackBar(
                            title: 'Validacion de datos',
                            message: 'Complete todos los campos.',
                            icon: Icon(Icons.app_registration),
                            duration: Duration(seconds: 4),
                            backgroundColor: Colors.red,
                          ));
                        } else {
                          if (_controllerGetxTurismo.id != "") {
                            editController.editSite(
                                _controllerGetxTurismo.id,
                                _nombreST.text,
                                _capacidadST.text,
                                _tipoTurismo.text,
                                _descripcionST.text,
                                _ubicacionST.toString(),
                                _uidUser,
                                fotografias
                            );
                          } else {
                            editController.saveSite(
                                _nombreST.text,
                                _capacidadST.text,
                                _tipoTurismo.text,
                                _descripcionST.text,
                                _ubicacionST.toString(),
                                _uidUser);
                          }
                          cleanForm();
                        }
                      },
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.green,
                          textStyle: const TextStyle(fontSize: 15)),
                      child: const Text("REGISTRAR"),
                    )
                  ],
                )
              ],
            )));
  }

  Widget textForm(TextEditingController _controller, String HintText,
      int LinesMax, TextInputType textInputType) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.green.shade300,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: TextFormField(
          controller: _controller,
          maxLines: LinesMax,
          keyboardType: textInputType,
          textCapitalization: TextCapitalization.sentences,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(16.0),
            hintText: HintText,
            hintStyle: TextStyle(color: Colors.white),
          )),
    );
  }

  Widget ListTravel(
      TextEditingController _tipoTurismo, List<String> listTypeCulture) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.green.shade300,
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16.0),
        ),
        isExpanded: true,
        dropdownColor: Colors.green.shade300,
        icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.white),
        items: listTypeCulture.map((listTypeCulture) {
          return DropdownMenuItem(
              value: listTypeCulture,
              child: Text(
                'Turismo $listTypeCulture',
                style: TextStyle(color: Colors.white),
              ));
        }).toList(),
        onChanged: ((value) => _tipoTurismo.text = "Turismo " + value!),
        hint: GetBuilder<GetxSitioTuristico>(
          init: GetxSitioTuristico(),
          builder: (controller) {
            return Text(controller.tipoTurismo.isEmpty ?
              "Seleccionar" : '${controller.tipoTurismo}');
          },
        ),
      ),
    );
  }

  //Funciones para localizacion
  void _getCurrentLocation() async {
    Position position = await _determinePosition();
    final GetxSitioTuristico _controllerGetxTurismo =
        Get.put(GetxSitioTuristico());

    _controllerGetxTurismo.updateUbicacion(position.toString());
    _ubicacionST = position.toString();
    messageInformation("Ubicacion",
        "Ubicacion actualizada.",
        Icon(Icons.gps_fixed),
        Colors.green);
  }

  Future<Position> _determinePosition() async {
    final GetxSitioTuristico _controllerGetxTurismo =
    Get.put(GetxSitioTuristico());
    _controllerGetxTurismo.updateUbicacion("Realizando ubicacion");

    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  void cleanForm() {
    _controllerGetxTurismo.cleanTurismo();
    _nombreST.clear();
    _capacidadST.clear();
    _descripcionST.clear();
    _tipoTurismo.clear();
    _ubicacionST = "";
  }
}

void messageInformation(
    String titulo, String mensaje, Icon icono, Color color) {
  Get.showSnackbar(GetSnackBar(
    title: titulo,
    message: mensaje,
    icon: icono,
    duration: Duration(seconds: 4),
    backgroundColor: color,
  ));
}
