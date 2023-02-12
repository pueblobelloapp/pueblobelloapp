import 'dart:io';

import 'package:app_turismo/Recursos/Controller/GextControllers/GexTurismo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:app_turismo/Recursos/Models/SiteTuristico.dart';
import 'package:get/get.dart';



class SiteTuristicoDataSource {

  User get currentUser {
    final myUsers = FirebaseAuth.instance.currentUser;
    if (myUsers == null) throw Exception('Not authenticated exception');
    return myUsers;
  }

  final GextControllerTurismo controllerTurismo =
  Get.put(GextControllerTurismo());


  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  FirebaseStorage get storage => FirebaseStorage.instance;

  // Generates and returns a new firestore id
  String newId() {
    return firestore.collection('sites').doc().id;
  }

  // Creates or updates a document in myUser collection. If image is not null
  // it will create or update the image in Firebase Storage
  Future<void> saveMySite(SitioTuristico sitioTuristico, File? image) async {
    final ref = firestore.doc('sites/${sitioTuristico.id}');


    if (image != null) {
      // Delete current image if exists
      if (sitioTuristico.foto != null) {
        await storage.refFromURL(sitioTuristico.foto!).delete();
      }

      final fileName = image.uri.pathSegments.last;
      final imagePath = '${currentUser.uid}/mySiteImages/$fileName';

      final storageRef = storage.ref(imagePath);
      await storageRef.putFile(image);
      final url = await storageRef.getDownloadURL();
      sitioTuristico = sitioTuristico.copyWith(foto: url);
    }
    await ref.set(sitioTuristico.toFirebaseMap(), SetOptions(merge: true));
  }

  Stream<Iterable<SitioTuristico>> getAllSites() {
    return firestore
        .collection('sites/')
        .snapshots()
        .map((it) => it.docs.map((e) => SitioTuristico.fromFirebaseMap(e.data())));
  }

  Stream<QuerySnapshot> getSitesUid() {
    print("Uid: " + controllerTurismo.uidUser);
    return firestore
        .collection('sites')
        .where("userId", isEqualTo: controllerTurismo.uidUser)
        .snapshots();
  }

}