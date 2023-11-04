import 'dart:io';
import 'package:app_turismo/Recursos/Controller/GextControllers/GetxManagementTouristSite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:app_turismo/Recursos/Models/SiteTuristico.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';

import '../Controller/GextControllers/GextUtils.dart';

class SiteTuristicoDataSource extends GetView<GetxManagementTouristSite> {
  final GetxUtils messageController = Get.put(GetxUtils());
  User get currentUser {
    final myUsers = FirebaseAuth.instance.currentUser;
    if (myUsers == null) throw Exception('Not authenticated exception');
    return myUsers;
  }

  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  FirebaseStorage get storage => FirebaseStorage.instance;

  // Generates and returns a new firestore id
  String newId() {
    return firestore.collection('sites').doc().id;
  }

  // Creates or updates a document in myUser collection. If image is not null
  // it will create or update the image in Firebase Storage
  Future<void> saveMySite(SitioTuristico sitioTuristico) async {
    final ref = firestore.doc('sites/${sitioTuristico.id}');
    List<String>? urlFotografias = [];
    print("Iniciando guardado: " + sitioTuristico.toString());

    if (controller.listCroppedFile.isNotEmpty) {
      urlFotografias = await uploadFiles(controller.listCroppedFile);
/*      sitioTuristico = sitioTuristico.copyWith(
          foto: urlFotografias, userId: controller.uidUserLogin);*/
      controller.listCroppedFile.clear();
      controller.listPickedFile.clear();

      print("Sitio:" + sitioTuristico.toFirebaseMap().toString());
      await ref.set(sitioTuristico.toFirebaseMap(), SetOptions(merge: false));
      messageController.messageInfo("Registro Sitio", "Sitio registrado");
    } else {
      messageController.messageError("Registro Sitio", "Error al guardar");
      print("Notificar que no se puede guardar.");
    }
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

  Stream<Iterable<SitioTuristico>> getAllSites() {
    return firestore.collection('sites/').snapshots().map(
        (it) => it.docs.map((e) => SitioTuristico.fromFirebaseMap(e.data())));
  }

  Stream<QuerySnapshot> getSitesUid() {
    //print("Uid: " + controller.uidUserLogin);
    return firestore
        .collection('sites')
        .where("userId", isEqualTo: "controller.uidUserLogin")
        .snapshots();
  }

  Stream<QuerySnapshot> getAvtivity() {
    return firestore.collection('actividades/').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
