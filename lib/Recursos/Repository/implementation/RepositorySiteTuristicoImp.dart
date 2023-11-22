import 'package:app_turismo/Recursos/Controller/GextControllers/GextUtils.dart';
import 'package:app_turismo/Recursos/Models/SiteTuristico.dart';
import 'package:app_turismo/Recursos/Repository/RepositorySiteTuristico.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/src/material/dropdown.dart';
import 'package:get/get.dart';
import '../../../main.dart';
import '../../DataSource/FirebaseSites.dart';

class MyRepositorySiteTuristicoImp extends MySitesRepository {
  final GetxUtils messageController = Get.put(GetxUtils());
  User get currentUser {
    final myUsers = FirebaseAuth.instance.currentUser;
    if (myUsers == null) throw Exception('Not authenticated exception');
    return myUsers;
  }

  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  FirebaseStorage get storage => FirebaseStorage.instance;

  @override
  Future<void> deleteMySite(SitioTuristico mySite) {
    // TODO: implement deleteMySite
    throw UnimplementedError();
  }

  @override
  String newId() { return firestore.collection('sites').doc().id; }

  @override
  Future<void> saveMySite(SitioTuristico sitioTuristico) async {
    final ref = firestore.doc('sites/${sitioTuristico.id}');
    List<String>? urlFotografias = [];
    print("Iniciando guardado: " + sitioTuristico.toString());

    /*if (controller.listCroppedFile.isNotEmpty) {
      urlFotografias = await uploadFiles(controller.listCroppedFile);
      sitioTuristico = sitioTuristico.copyWith(
          foto: urlFotografias, userId: controller.uidUserLogin);
      controller.listCroppedFile.clear();
      controller.listPickedFile.clear();

      print("Sitio:" + sitioTuristico.toFirebaseMap().toString());
      await ref.set(sitioTuristico.toFirebaseMap(), SetOptions(merge: false));
      messageController.messageInfo("Registro Sitio", "Sitio registrado");
    } else {
      messageController.messageError("Registro Sitio", "Error al guardar");
      print("Notificar que no se puede guardar.");
    }*/
  }

  @override
  Future<void> editMySite(SitioTuristico mySite) {
    // TODO: implement editMySite
    throw UnimplementedError();
  }

  @override
  Stream<QuerySnapshot> getSitesUid() {
    // TODO: implement getSitesUid
    print("Usuario sitios:" + currentUser.uid);
    return firestore
        .collection('sites')
        .where("userId", isEqualTo: currentUser.uid)
        .snapshots();
  }

  @override
  Stream<QuerySnapshot> getAvtivity() {
    return firestore.collection('actividades/').snapshots();
  }
}
