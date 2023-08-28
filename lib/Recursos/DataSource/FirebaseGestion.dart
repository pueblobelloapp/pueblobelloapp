import 'dart:io';
import 'package:app_turismo/Recursos/Controller/GextControllers/GetxGestionInformacion.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GetxSitioTuristico.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GextUtils.dart';
import 'package:app_turismo/Recursos/Models/InfoMunicipio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';

class GestionDataBase {
  final GetxUtils messageController = Get.put(GetxUtils());

  List<dynamic> urlFotografias = [];

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
  Future<void> saveGestion(InfoMunicipio infoMunicipio) async {
    final ref = firestore.doc('dataTurismo/${infoMunicipio.id}');
    List<SubTitulo> listSubInformation = [];

    if (infoMunicipio.photos!.length > 0) {
      List<CroppedFile>? cropFiles = infoMunicipio.photos?.map((dynamic element) {
        if (element is CroppedFile) {
          return element;
        }
      }).whereType<CroppedFile>().toList();

      urlFotografias = await uploadFiles(cropFiles!);
      print("Completando carga de fotos 1");
      infoMunicipio.photos?.clear();
      infoMunicipio = infoMunicipio.copyWith(photos: urlFotografias);
    }

    for (var item in infoMunicipio.subTitulos) {
        List<CroppedFile>? cropFiles = item.listPhotosPath?.map((dynamic element) {
          if (element is CroppedFile) return element;
        }).whereType<CroppedFile>().toList();

        urlFotografias = await uploadFiles(cropFiles!);
        item.listPhotosPath?.clear();
        item = item.copyWith(listPhotosPath: urlFotografias);
        listSubInformation.add(item);
    }

    infoMunicipio = infoMunicipio.copyWith(subTitulos: listSubInformation);
    await ref.set(infoMunicipio.toFirebaseMap(), SetOptions(merge: true));
  }

  Future<List<String>> uploadFiles(List<CroppedFile> _images) async {
    var imageUrls =
        await Future.wait(_images.map((_image) => uploadFile(_image)));
    return imageUrls;
  }

  Future<String> uploadFile(CroppedFile _image) async {
    final storageReference = storage.ref().child('municipio/${_image.path}');
    await storageReference.putFile(File(_image.path));
    return await storageReference.getDownloadURL();
  }

/*  Stream<Iterable<InfoMunicipio>> getAllSites() {
    return firestore.collection('dataTurismo/').snapshots().map(
        (it) => it.docs.map((e) => InfoMunicipio.fromFirebaseMap(e.data())));
  }*/
}
