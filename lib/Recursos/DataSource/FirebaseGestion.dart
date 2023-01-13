import 'dart:io';
import 'package:app_turismo/Recursos/Controller/GextControllers/GexTurismo.dart';
import 'package:app_turismo/Recursos/Models/GestionModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class GestionDataBase {

  final GextControllerTurismo _controllerTurismo =
  Get.put(GextControllerTurismo());

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
  Future<void> saveGestion(GestionModel myGestionModel, File? image) async {
    final ref = firestore.doc(
        '${_controllerTurismo.typeInformation}/${myGestionModel.id}');

    if (image != null) {
      // Delete current image if exists
      if (myGestionModel.foto != null) {
        await storage.refFromURL(myGestionModel.foto!).delete();
      }

      final fileName = image.uri.pathSegments.last;
      final imagePath = '${currentUser.uid}/my${_controllerTurismo.typeInformation}Images/$fileName';

      final storageRef = storage.ref(imagePath);
      await storageRef.putFile(image);
      final url = await storageRef.getDownloadURL();
      myGestionModel = myGestionModel.copyWith(foto: url);
    }
    await ref.set(myGestionModel.toFirebaseMap(), SetOptions(merge: true));
  }

  Stream<Iterable<GestionModel>> getAllSites() {
    return firestore
        .collection('${_controllerTurismo.typeInformation}/')
        .snapshots()
        .map((it) => it.docs.map((e) => GestionModel.fromFirebaseMap(e.data())));
  }


}