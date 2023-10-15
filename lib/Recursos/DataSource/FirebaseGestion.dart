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

  Future<void> saveGestion(InfoMunicipio infoMunicipio) async {
    final ref = firestore.doc('dataTurismo/${infoMunicipio.id}');
    List<SubTitulo> listSubInformation;
    infoMunicipio = await uploadPhotosMain(infoMunicipio);
    listSubInformation = await uploadPhotosSubMain(infoMunicipio);
    infoMunicipio = infoMunicipio.copyWith(subTitulos: listSubInformation);
    await ref.set(infoMunicipio.toFirebaseMap(), SetOptions(merge: true));
  }

  Future<void> updateInfoMain(InfoMunicipio infoMunicipio, int index) async {
    print("Valor Actualizar: " + infoMunicipio.nombre);
    final ref = firestore.doc('dataTurismo/${infoMunicipio.id}');

    if (index == -1) {
      infoMunicipio = await uploadPhotosMain(infoMunicipio);
    } else {
      //ARREGLAR LAS SUBFOTOS FALTA LOGICA
      List<SubTitulo> listSubInformation = await uploadPhotosSubMain(infoMunicipio);
      infoMunicipio = infoMunicipio.copyWith(subTitulos: listSubInformation);
    }

    await ref.set(infoMunicipio.toFirebaseMap(), SetOptions(merge: true));
  }

/*  Future<void> updateInformationGeneral(InfoMunicipio infoMunicipio, int index, List<String> photosSub,
      List<String> photosMain) async {
    SubTitulo subTitulo = infoMunicipio.subTitulos[0];

    final ref = firestore.doc('dataTurismo/${infoMunicipio.id}');

    if (index == -1) {
      infoMunicipio = await uploadPhotosMain(infoMunicipio);
    } else {
      subTitulo = await updatePhotosSubInformationForIndex(infoMunicipio.subTitulos[index], photosSub);
      infoMunicipio.subTitulos[index] = subTitulo;
    }

    getxSitioTuristico.mapUbications = new Ubicacion(lat: "10.422522", long: "-73.578462");
    await ref.set(infoMunicipio.toFirebaseMap(), SetOptions(merge: true));
  }*/

  Future<InfoMunicipio> uploadPhotosMain(InfoMunicipio infoMunicipio) async {
    List<dynamic> newPhotosUrls = [];
    List<dynamic> oldPhotosUrls = [];

    List<CroppedFile>? cropFiles = infoMunicipio.photos
        ?.map((dynamic element) {
          if (element is CroppedFile) {
            print("Captura elemento");
            return element;
          } else if (element is String) {
            print("oldPhotosUrls");
            oldPhotosUrls.add(element);
          }
        })
        .whereType<CroppedFile>()
        .toList();

    if (cropFiles!.length >= 1) {
      print("Hace cargue de fotos principal");
      newPhotosUrls = await uploadFiles(cropFiles);
      oldPhotosUrls.forEach((dynamic element) {
        if (element is String) {
          newPhotosUrls.add(element);
        }
      });
      infoMunicipio = infoMunicipio.copyWith(photos: newPhotosUrls);
    }

    return infoMunicipio;
  }

  Future<List<SubTitulo>> uploadPhotosSubMain(InfoMunicipio infoMunicipio) async {
    List<dynamic> newUrlPhotos = [];
    List<dynamic> oldUrlPhotos = [];

    List<SubTitulo> listSubInformation = [];
    for (var item in infoMunicipio.subTitulos) {
      if (item.listPhotosPath!.isNotEmpty) {
        List<CroppedFile>? cropFiles = item.listPhotosPath
            ?.map((dynamic element) {
              if (element is CroppedFile) {
                return element;
              } else if (element is String) {
                oldUrlPhotos.add(element);
              }
            })
            .whereType<CroppedFile>()
            .toList();

        newUrlPhotos = cropFiles!.isEmpty ? [] : await uploadFiles(cropFiles);
        oldUrlPhotos.forEach((dynamic element) {
          if (element is String) {
            newUrlPhotos.add(element);
          }
        });
        item.listPhotosPath!.clear();
        item = item.copyWith(listPhotosPath: newUrlPhotos);
        listSubInformation.add(item);
      } else {
        listSubInformation.add(item);
      }
    }
    return listSubInformation;
  }

  //Cargue de fotografias por index
  /*Future<SubTitulo> updatePhotosSubInformationForIndex(SubTitulo subTitulo, List<String> photos) async {
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
  }*/

  Future<List<String>> uploadFiles(List<CroppedFile> _images) async {
    var imageUrls = await Future.wait(_images.map((_image) => uploadFile(_image)));
    return imageUrls;
  }

  Future<String> uploadFile(CroppedFile _image) async {
    final storageReference = storage.ref().child('test/imagesTest');
    await storageReference.putFile(File(_image.path));
    return await storageReference.getDownloadURL();
  }
}
