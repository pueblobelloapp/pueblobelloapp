import 'dart:io';
import 'package:app_turismo/Recursos/Controller/GextControllers/GextPropietarioController.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GextUtils.dart';
import 'package:app_turismo/Recursos/Models/PropietarioModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PropietarioDataBase {
  final GetxUtils messageController = Get.put(GetxUtils());
  final GextPropietarioController propietarioController =
      Get.put(GextPropietarioController());
  var myUsers = null;

  User get currentUser {
    myUsers = FirebaseAuth.instance.currentUser;
    if (myUsers == null) throw Exception('No autenticado.');
    return myUsers;
  }

  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  FirebaseStorage get storage => FirebaseStorage.instance;

  String newId() {
    return firestore.collection("propietarios").doc().id;
  }

  Future<void> saveImageProfile() async {
    User myusuario = currentUser;
    String urlPhoto;
    if (propietarioController.imagePerfil.value.path.isNotEmpty) {
      final ref = firestore.doc('propietario/${myusuario.uid}');
      urlPhoto = await uploadPhoto(
          propietarioController.imagePerfil.value, myusuario.uid);

      final fileName = propietarioController.imagePerfil.value.name;
      final imagePath = '${currentUser.uid}/mySiteImages/$fileName';

      final storageRef = storage.ref(imagePath);
      await storageRef
          .putFile(File(propietarioController.imagePerfil.value.path));
      final url = await storageRef.getDownloadURL();
      await ref
          .update({'foto': url})
          .then((value) => {
                messageController.messageInfo("Perfil", "Foto actualizada"),
                propietarioController.imagePerfilUrl.value = url
              })
          .onError((error, stackTrace) => {
                messageController.messageError(
                    "Error perfil", "Error al guardar: " + error.toString())
              });
      //propietario = propietario.copyWith(foto: url);
    } else {
      print("Sin imagen");
    }
  }

  Future<void> savePropietario(Propietario propietario) async {
    final ref = firestore.doc('propietario/${propietario.id}');
    print("Iniciando guardado: " + propietario.toString());

    User myusuario = currentUser;

    try {
      await myusuario.updateEmail(propietario.correo.trim());
      await ref
          .set(propietario.toFirebaseMap(), SetOptions(merge: true))
          .then((value) => {
                messageController.messageError(
                    "Actualizacion", "Actualizacion correcta.")
              })
          .onError((error, stackTrace) => {
                messageController.messageError("Actualizacion",
                    "Ups! Ocurrio un error inesperado." + error.toString())
              });
    } on FirebaseException catch (e) {
      if (e.code == "requires-recent-login") {
        messageController.messageError("Actualizacion",
            "Inicia sesion nuevamente para verificar: " + e.code);
        return Future.error('requires-recent-login');
      }
    }
  }

  Future<String> uploadPhoto(XFile? file, String id) async {
    final storageReference = storage.ref().child('post/${id}/${file?.path}');
    await storageReference.putFile(File(file!.path));
    return await storageReference.getDownloadURL();
  }

  Stream<Iterable<Propietario>> getAllPropietario() {
    return firestore
        .collection('propietario/')
        .snapshots()
        .map((it) => it.docs.map((e) => Propietario.fromFirebaseMap(e.data())));
  }

  //Modificacion para clave y contraseña del usuario propietario
  Future<void> informationUser() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        print("Update Email: " + user.uid);
      }
    });
  }
}
