
import 'dart:io';

import 'package:app_turismo/Recursos/Models/PropietarioModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class PropietarioDataBase {

  User get currentUser {
    final myUsers = FirebaseAuth.instance.currentUser;
    if (myUsers == null) throw Exception('Not authenticated exception');
    return myUsers;
  }

  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  FirebaseStorage get storage => FirebaseStorage.instance;

  String newId() {
    return firestore.collection("propietarios").doc().id;
  }

  Future<void> saveGestion(Propietario propietario, File? image) async {
    final ref = firestore.doc(
        'propietario/${propietario.id}');

    if (image != null) {
      // Delete current image if exists
      if (propietario.foto != null) {
        await storage.refFromURL(propietario.foto!).delete();
      }

      final fileName = image.uri.pathSegments.last;
      final imagePath = '${currentUser.uid}/myPropietarioImages/$fileName';

      final storageRef = storage.ref(imagePath);
      await storageRef.putFile(image);
      final url = await storageRef.getDownloadURL();
      propietario = propietario.copyWith(foto: url);
    }
    await ref.set(propietario.toFirebaseMap(), SetOptions(merge: true));
  }

  Stream<Iterable<Propietario>> getAllPropietario() {
    return firestore
        .collection('propietario/')
        .snapshots()
        .map((it) => it.docs.map((e) => Propietario.fromFirebaseMap(e.data())));
  }
}