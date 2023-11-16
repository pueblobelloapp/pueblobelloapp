import 'dart:async';
import 'dart:io';
import 'package:app_turismo/Recursos/Controller/GextControllers/GetxManagementMunicipality.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GetxManagementTouristSite.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GextUtils.dart';
import 'package:app_turismo/Recursos/Models/InfoMunicipio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';

class GestionDataBase {
  final ManagementMunicipalityController controllerGestionInformacion =
      Get.put(ManagementMunicipalityController());

  final GetxManagementTouristSite getxSitioTuristico = Get.put(GetxManagementTouristSite());
  final GetxUtils controllerUtils = Get.put(GetxUtils());

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

  Future<void> saveInformation(InfoMunicipio infoMunicipio) async {
    final ref = firestore.doc('dataTurismo/${infoMunicipio.id}');
    List<SubTitulo> listSubInformation;
    infoMunicipio = await uploadPhotosMain(infoMunicipio);
    listSubInformation = await uploadPhotosSubMain(infoMunicipio);
    infoMunicipio = infoMunicipio.copyWith(subTitulos: listSubInformation);
    await ref.set(infoMunicipio.toFirebaseMap(), SetOptions(merge: true));
  }

  Future<void> updateInformation(InfoMunicipio infoMunicipio, int index) async {
    final ref = firestore.doc('dataTurismo/${infoMunicipio.id}');

    try {
      if (index == -1) {
        infoMunicipio = await uploadPhotosMain(infoMunicipio);
      } else {
        List<SubTitulo> listSubInformation = await uploadPhotosSubMain(infoMunicipio);
        infoMunicipio = infoMunicipio.copyWith(subTitulos: listSubInformation);
      }
      await ref.set(infoMunicipio.toFirebaseMap(), SetOptions(merge: false));
    } on TimeoutException {
      controllerUtils.messageError("Error", "Lo sentimos no pudimos completar la actualización.");
    }
  }

  Future<InfoMunicipio> uploadPhotosMain(InfoMunicipio infoMunicipio) async {
    List<String> newPhotosUrls = [];
    List<String> oldPhotosUrls = [];

    List<CroppedFile>? cropFiles = infoMunicipio.photos
        .map((dynamic elementNewPhotos) {
          if (elementNewPhotos is CroppedFile) {
            return elementNewPhotos;
          } else if (elementNewPhotos is String) {
            oldPhotosUrls.add(elementNewPhotos);
          }
        })
        .whereType<CroppedFile>()
        .toList();

    if (cropFiles.length >= 1) {
      infoMunicipio.photos.clear();
      newPhotosUrls = await uploadFiles(cropFiles);
      cropFiles.clear();
      infoMunicipio.photos.addAll(oldPhotosUrls);
      infoMunicipio.photos.addAll(newPhotosUrls);
    }

    return infoMunicipio;
  }

  Future<List<SubTitulo>> uploadPhotosSubMain(InfoMunicipio infoMunicipio) async {
    List<SubTitulo> listSubInformation = [];
    for (var item in infoMunicipio.subTitulos) {
      List<dynamic> newUrlPhotos = [];
      List<dynamic> oldUrlPhotos = [];
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

        item.listPhotosPath!.clear();
        newUrlPhotos = await uploadFiles(cropFiles!);
        oldUrlPhotos.forEach((dynamic element) {
          if (element is String) {
            item.listPhotosPath!.add(element);
          }
        });
        newUrlPhotos.forEach((dynamic element) {
          if (element is String) {
            item.listPhotosPath!.add(element);
          }
        });

        listSubInformation.add(item);
      } else {
        listSubInformation.add(item);
      }
    }
    return listSubInformation;
  }

  Future<List<String>> uploadFiles(List<CroppedFile> _images) async {
    var imageUrls = await Future.wait(_images.map((_image) => uploadFile(_image)));
    return imageUrls;
  }

  Future<String> uploadFile(CroppedFile _image) async {
    final now = DateTime.now();
    var uuid = now.microsecondsSinceEpoch.toString();
    final storageReference = storage.ref().child('test/imagesTest/${uuid}');
    await storageReference.putFile(File(_image.path));
    return await storageReference.getDownloadURL();
  }

  Future<void> deletePhotoFromList(
      String idDocumento,
      int mapIndex,
      String? urlString) async {

    final documentosPhotos =
        await firestore.collection('dataTurismo').where('photos', arrayContains: urlString).get();
    for (final doc in documentosPhotos.docs) {
      doc.reference.update({
        'photos': FieldValue.arrayRemove([urlString]),
      }).then((value) {
        controllerUtils.messageInfo("Fotografia", "Fotografia eliminada correctamente.");
      });
    }

    final documentReference = FirebaseFirestore.instance.collection('dataTurismo').doc(idDocumento);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(documentReference);
      final data = snapshot.data() as Map<String, dynamic>;
      final subTitulosList = data['subTitulos'] as List;

      if (mapIndex >= 0 && mapIndex < subTitulosList.length) {
        final subTitulo = subTitulosList[mapIndex] as Map<String, dynamic>;
        final listPhotos = subTitulo['listPhotos'] as List;

        if (listPhotos.contains(urlString)) {
          listPhotos.remove(urlString);
          subTitulo['listPhotos'] = listPhotos;
          transaction.update(documentReference, {
            'subTitulos': subTitulosList,
          });
        }
      }
    });
  }

  Future<void> deleteMapFromList(String documentId, int mapIndex) async {
    try {
      final documentReference =
          FirebaseFirestore.instance.collection('dataTurismo').doc(documentId);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final snapshot = await transaction.get(documentReference);
        final data = snapshot.data() as Map<String, dynamic>;
        final mapList = data['subTitulos'] as List;

        if (mapIndex >= 0 && mapIndex < mapList.length) {
          mapList.removeAt(mapIndex);
          transaction.update(documentReference, {'subTitulos': mapList});
        } else if (mapIndex == -1) {
          documentReference.delete();
        }
      }).then((value) {
        controllerUtils.messageInfo("Información", "Registro eliminado");
      }).onError((error, stackTrace) {
        controllerUtils.messageError("Error", "Ups! Error al eliminar: ${error.toString()}");
      });
    } catch (e) {
      controllerUtils.messageError("Información", "Lo sentimos no pudimos completar la accion: ${e}");
    }
  }
}
