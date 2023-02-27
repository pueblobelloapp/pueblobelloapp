import 'dart:io';
import 'package:app_turismo/Recursos/Controller/GextControllers/GetxGestionInformacion.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GexTurismo.dart';
import 'package:app_turismo/Recursos/Models/GestionModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class GestionDataBase {

  final GextControllerTurismo _controllerTurismo =
  Get.put(GextControllerTurismo());

  final GetxGestionInformacionController controllerGestionInformacion =
  Get.put(GetxGestionInformacionController());

  User get currentUser {
    final myUsers = FirebaseAuth.instance.currentUser;
    if (myUsers == null) throw Exception('Not authenticated exception');
    return myUsers;
  }

  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  FirebaseStorage get storage => FirebaseStorage.instance;

  String newId() {
    return firestore.collection(_controllerTurismo.typeInformation).doc().id;
  }

  //Funcion para añadir una nueva informacion cultural.
  Future<void> saveGestion(GestionModel myGestionModel) async {
    final ref = firestore.doc(
        '${_controllerTurismo.typeInformation}/${myGestionModel.id}');
    List<String>? urlFotografias = [];

    if (controllerGestionInformacion.imageFileList.isNotEmpty) {
      print("Entra si 1");
      // Delete current image if exists
      //TODO: se debe implementar una logica distinta debido a que hora viene varias fotos.
      //y borrar las demas fotografias para poder sobreescribir  y horrar espacios.
      if (myGestionModel.foto == null) {
        //TODO: Se debe recorrer la lista de URL y mandar uno a uno a borrar.
        //await storage.refFromURL(sitioTuristico.foto).delete();
        print("SITIO TURIASTICO ES VACIO");
      } else {
        print("Busca fotos");
        /*TODO: Sebe recorrer la lista de fotografias con las URLs traidas, y agregarlas
        *  en firebase para poder visualizarlas al usuario final.*/
        urlFotografias = await uploadFiles(controllerGestionInformacion.imageFileList);
        print("Resultados: " + urlFotografias.toString());
      }

      myGestionModel = myGestionModel.copyWith(foto: urlFotografias);
    }
    await ref.set(myGestionModel.toFirebaseMap(), SetOptions(merge: true));
  }

  Future <List<String>> uploadFiles(List<XFile> _images) async {
    var imageUrls = await Future.wait(_images.map((_image) => uploadFile(_image)));
    return imageUrls;
  }

  Future<String> uploadFile(XFile _image) async {
    final storageReference = storage.ref().child('posts/${_image.path}');
    await storageReference.putFile(File(_image.path));
    return await storageReference.getDownloadURL();
  }

  Stream<Iterable<GestionModel>> getAllSites() {
    return firestore
        .collection('${_controllerTurismo.typeInformation}/')
        .snapshots()
        .map((it) => it.docs.map((e) => GestionModel.fromFirebaseMap(e.data())));
  }


}