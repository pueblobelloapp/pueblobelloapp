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

  final GetxGestionInformacionController controllerGestionInformacion =
      Get.put(GetxGestionInformacionController());

  final GetxSitioTuristico getxSitioTuristico = Get.put(GetxSitioTuristico());

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
    List<SubTitulo> listSubInformation;
    infoMunicipio = await uploadPhotosMain(infoMunicipio);
    listSubInformation = await uploadPhotosSubMain(infoMunicipio);

    getxSitioTuristico.mapUbications = new Ubicacion(lat: "10.422522", long: "-73.578462");

    infoMunicipio = infoMunicipio.copyWith(subTitulos: listSubInformation);
    await ref.set(infoMunicipio.toFirebaseMap(), SetOptions(merge: true));
  }

  Future<void> editGestion(InfoMunicipio infoMunicipio, int index, List<String> photosSub,
      List<String> photosMain) async {

    final ref = firestore.doc('dataTurismo/${infoMunicipio.id}');

    infoMunicipio = await uploadPhotosMain(infoMunicipio);
    if (photosMain.length > 0) {
      infoMunicipio.photos!.addAll(photosMain);
    }

    SubTitulo subTitulo = await uploadPhotosIndex(infoMunicipio.subTitulos[index], photosSub);

    infoMunicipio.subTitulos[index] = subTitulo;
    getxSitioTuristico.mapUbications = new Ubicacion(lat: "10.422522", long: "-73.578462");
    await ref.set(infoMunicipio.toFirebaseMap(), SetOptions(merge: true));
  }

  Future<InfoMunicipio> uploadPhotosMain(InfoMunicipio infoMunicipio) async {
    List<dynamic> urlFotografias = [];
    List<CroppedFile>? cropFiles = infoMunicipio.photos
        ?.map((dynamic element) {
          if (element is CroppedFile) {
            print("Captura elemento");
            return element;
          }
        })
        .whereType<CroppedFile>()
        .toList();

   if (cropFiles!.length >= 1) {
     print("Hace cargue de foto sprincipal");
     infoMunicipio.photos!.clear();
     urlFotografias = await uploadFiles(cropFiles!);
     infoMunicipio = infoMunicipio.copyWith(photos: urlFotografias);
   }

    return infoMunicipio;
  }

  Future<List<SubTitulo>> uploadPhotosSubMain(InfoMunicipio infoMunicipio) async {
    List<dynamic> urlFotografias = [];
    List<SubTitulo> listSubInformation = [];
    for (var item in infoMunicipio.subTitulos) {
      if (item.listPhotosPath!.isNotEmpty) {
        List<CroppedFile>? cropFiles = item.listPhotosPath
            ?.map((dynamic element) {
              if (element is CroppedFile) return element;
            })
            .whereType<CroppedFile>()
            .toList();

        urlFotografias = await uploadFiles(cropFiles!);
        item.listPhotosPath?.clear();
        item = item.copyWith(listPhotosPath: urlFotografias);
        listSubInformation.add(item);
      } else {
        listSubInformation.add(item);
      }
    }
    return listSubInformation;
  }

  Future<SubTitulo> uploadPhotosIndex(SubTitulo subTitulo, List<String> photos) async {
      List<dynamic> urlFotografias = [];
      List<CroppedFile>? cropFiles = subTitulo.listPhotosPath
          ?.map((dynamic element) {
            if (element is CroppedFile) return element;
          })
          .whereType<CroppedFile>()
          .toList();


      if (cropFiles!.length >= 1) {
        print("Gaurdando fotos de sub");
        subTitulo.listPhotosPath?.clear();
        urlFotografias = await uploadFiles(cropFiles!);
        urlFotografias.addAll(photos);
        subTitulo = subTitulo.copyWith(listPhotosPath: urlFotografias);
      }

    return subTitulo;
  }

  Future<List<String>> uploadFiles(List<CroppedFile> _images) async {
    var imageUrls = await Future.wait(_images.map((_image) => uploadFile(_image)));
    return imageUrls;
  }

  Future<String> uploadFile(CroppedFile _image) async {
    final storageReference = storage.ref().child('test/${_image.path}');
    await storageReference.putFile(File(_image.path));
    return await storageReference.getDownloadURL();
  }
}
