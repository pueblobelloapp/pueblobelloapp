import 'dart:io';
import 'package:app_turismo/Recursos/Controller/GextControllers/GetxGestionInformacion.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GetxMunicipioController.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GetxSitioTuristico.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GextUtils.dart';
import 'package:app_turismo/Recursos/Models/InfoMunicipio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class GestionDataBase {
  final GetxUtils messageController = Get.put(GetxUtils());
/*

  final GetxMunicipioController _controllerTurismo =
      Get.put(GetxMunicipioController());

  final GetxSitioTuristico getxSitioTuristico = Get.put(GetxSitioTuristico());
*/

  final GetxGestionInformacionController controllerGestionInformacion =
      Get.put(GetxGestionInformacionController());

  final GetxSitioTuristico getxSitioTuristico =
      Get.put(GetxSitioTuristico());

  User get currentUser {
    final myUsers = FirebaseAuth.instance.currentUser;
    if (myUsers == null) throw Exception('Not authenticated exception');
    return myUsers;
  }

  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  FirebaseStorage get storage => FirebaseStorage.instance;

  String newId() {
    return firestore.collection('dataTurismo').doc().id;
  }

  //Funcion para añadir una nueva informacion.
  Future<void> saveGestion(InfoMunicipio myGestionModel) async {
    final ref = firestore.doc('dataTurismo/${myGestionModel.id}');
    List<String>? urlFotografias = [];

    //

    if (getxSitioTuristico.listCroppedFile.isNotEmpty) {
      urlFotografias =
          await uploadFiles(getxSitioTuristico.listCroppedFile);
      myGestionModel = myGestionModel.copyWith(foto: urlFotografias);
    } else {
      print("Listado de fotografias vacio.");
    }

    await ref.set(myGestionModel.toFirebaseMap(), SetOptions(merge: true));
  }

  Future<List<String>> uploadFiles(List<CroppedFile> _images) async {
    var imageUrls =
        await Future.wait(_images.map((_image) => uploadFile(_image)));
    return imageUrls;
  }

  Future<String> uploadFile(CroppedFile _image) async {
    final storageReference = storage.ref().child('posts/${_image.path}');
    await storageReference.putFile(File(_image.path));
    return await storageReference.getDownloadURL();
  }

  Stream<Iterable<InfoMunicipio>> getAllSites() {
    return firestore.collection('dataTurismo/').snapshots().map(
        (it) => it.docs.map((e) => InfoMunicipio.fromFirebaseMap(e.data())));
  }

  Future<void> deleteInformation(String uid, String module) async {
    print("Informacion: " + uid + " modulo: " + module);
    final ref = firestore.doc('dataTurismo/${uid}');
    await ref
        .delete()
        .then((value) => {
              messageController.messageInfo(
                  "Informacion", "Se elimino correctamente"),
            })
        .onError((error, stackTrace) => {
              messageController.messageError(
                  "Error module", "Error al eliminar: " + error.toString())
            });
  }
}
