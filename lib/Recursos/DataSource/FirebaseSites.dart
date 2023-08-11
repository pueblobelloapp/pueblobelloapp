import 'dart:io';
import 'package:app_turismo/Recursos/Controller/GextControllers/GexTurismo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:app_turismo/Recursos/Models/SiteTuristico.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../Paginas/ModuleTouristSite/Getx/GetxSitioTuristico.dart';

class SiteTuristicoDataSource {
  User get currentUser {
    final myUsers = FirebaseAuth.instance.currentUser;
    if (myUsers == null) throw Exception('Not authenticated exception');
    return myUsers;
  }

  final GextControllerTurismo controllerTurismo =
      Get.put(GextControllerTurismo());

  /*final GetxSitioTuristico controllerSitioTuristicos =
      Get.put(GetxSitioTuristico());*/

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

    /*TODO: Si no es vacio entonces selecciono fotografias, se debe borrar,
    * tener en cuenta, borrar fotografias que ya se tenian guardadas para poder
    * actualizar las que vienen.
    * */
    /*if (controllerSitioTuristicos.imageFileList.isNotEmpty) {
      print("Busca fotos");
      urlFotografias =
          await uploadFiles(controllerSitioTuristicos.imageFileList);
      print("Resultados: " + urlFotografias.toString());
      sitioTuristico = sitioTuristico.copyWith(foto: urlFotografias);
      controllerSitioTuristicos.imageFileList.clear();
    }*/
    await ref.set(sitioTuristico.toFirebaseMap(), SetOptions(merge: true));
  }

  Future<List<String>> uploadFiles(List<XFile> _images) async {
    var imageUrls =
        await Future.wait(_images.map((_image) => uploadFile(_image)));
    return imageUrls;
  }

  Future<String> uploadFile(XFile _image) async {
    final storageReference = storage.ref().child('posts/${_image.path}');
    await storageReference.putFile(File(_image.path));
    return await storageReference.getDownloadURL();
  }

  Stream<Iterable<SitioTuristico>> getAllSites() {
    return firestore.collection('sites/').snapshots().map(
        (it) => it.docs.map((e) => SitioTuristico.fromFirebaseMap(e.data())));
  }

  Stream<QuerySnapshot> getSitesUid() {
    print("Uid: " + controllerTurismo.uidUser);
    return firestore
        .collection('sites')
        .where("userId", isEqualTo: controllerTurismo.uidUser)
        .snapshots();
  }

  Future<List<DropdownMenuItem<String>>> getAvtivity() async {
    List<DropdownMenuItem<String>> menuItems = [];

    var listData = firestore.collection('actividades/').snapshots();
    var activities;

    listData.listen((snapshot) {
      snapshot.docs.forEach((doc) {
        activities = doc.data()['activity'];
        for (var i = 0; i < activities.length; i++) {
          menuItems.add(DropdownMenuItem(
              child: Text(activities[i]), value: activities[i]));
          print("Longitud: " + menuItems.length.toString());
        }
      });
    });

    print("Longitud: " + menuItems.length.toString());
    return menuItems;
  }
}
