import 'dart:io';
import 'package:app_turismo/Recursos/Controller/GextControllers/GetxGestionInformacion.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GexTurismo.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GextUtils.dart';
import 'package:app_turismo/Recursos/Models/GestionModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class GestionDataBase {

  final GetxUtils messageController = Get.put(GetxUtils());

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

  //Funcion para añadir una nueva informacion.
  Future<void> saveGestion(GestionModel myGestionModel) async {
    final ref = firestore.doc(
        '${_controllerTurismo.typeInformation}/${myGestionModel.id}');
    List<String>? urlFotografias = [];

    if (controllerGestionInformacion.imageFileList.isNotEmpty) {
      urlFotografias = await uploadFiles(controllerGestionInformacion.imageFileList);
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

  Future<void> deleteInformation(String uid, String module) async {
    print("Informacion: " + uid +" modulo: " + module);
    final ref = firestore.doc('${module}/${uid}');
    await ref.delete().then((value) =>  {
      messageController.messageInfo("Informacion", "Se elimino correctamente"),
    })
        .onError((error, stackTrace) => {messageController.messageError(
        "Error module", "Error al eliminar: " + error.toString())
    });
  }


}