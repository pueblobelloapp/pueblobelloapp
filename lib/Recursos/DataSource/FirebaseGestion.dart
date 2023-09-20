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

  //Funcion para añadir una nueva informacion.
  Future<void> editGestion(InfoMunicipio infoMunicipio, int index, List<String> photosSub,
      List<String> photosMain) async {
    List<String> listPhotosUrlsMain = [];
    final ref = firestore.doc('dataTurismo/${infoMunicipio.id}');
    List<String> listPhotosUrlsSub = infoMunicipio.subTitulos[index].listPhotosPath!
        .where((element) => element is String)
        .map((element) => element.toString())
        .toList();

    SubTitulo listSubInformation;

    //1. Validar si hay fotos nuevas que agregar de la pricipal
    //1.1 Si existe: Recorrer y agregar a lista con las existentes.
    infoMunicipio = await uploadPhotosMain(infoMunicipio);
    if (infoMunicipio.photos!.isNotEmpty) {
      listPhotosUrlsMain = infoMunicipio.photos!
          .where((element) => element is String)
          .map((element) => element.toString())
          .toList();

      infoMunicipio.photos!.addAll(listPhotosUrlsMain);
    } else if (photosMain.isNotEmpty){
      infoMunicipio.photos = photosMain;
    } else {
      print("Sin fotografias");
    }

    //2. Validar si hay fotos del subtitulo especifico para actualizar.
    //2.2 Si existe: Recorrer y agregar a la lista con los existente
    if (infoMunicipio.subTitulos[index].listPhotosPath!.isNotEmpty) {
      listSubInformation = await uploadPhotosIndex(infoMunicipio.subTitulos[index]);
    } else {
      infoMunicipio.subTitulos[index].listPhotosPath = listPhotosUrlsSub;
    }

    //3 Realizar merge entre lo nuevo y lo existente
    //infoMunicipio.subTitulos[index] = listSubInformation;

    //4 Guardar datos.
    infoMunicipio = infoMunicipio.copyWith(subTitulos: infoMunicipio.subTitulos);
    await ref.set(infoMunicipio.toFirebaseMap(), SetOptions(merge: true));
  }

//Validar en el for si tambien viene un string que es la URL de las fotografias.
  Future<InfoMunicipio> uploadPhotosMain(InfoMunicipio infoMunicipio) async {
    if (infoMunicipio.photos!.length > 0) {
      List<CroppedFile>? cropFiles = infoMunicipio.photos
          ?.map((dynamic element) {
            if (element is CroppedFile) {
              return element;
            }
          })
          .whereType<CroppedFile>()
          .toList();

      urlFotografias = await uploadFiles(cropFiles!);
      infoMunicipio.photos?.clear();
      infoMunicipio = infoMunicipio.copyWith(photos: urlFotografias);

      return infoMunicipio;
    } else {
      return infoMunicipio;
    }
  }

//Validar en el for si tambien viene un string que es la URL de las fotografias.
  Future<List<SubTitulo>> uploadPhotosSubMain(InfoMunicipio infoMunicipio) async {
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

  Future<SubTitulo> uploadPhotosIndex(SubTitulo subTitulo) async {
    if (subTitulo.listPhotosPath!.isNotEmpty) {
      List<CroppedFile>? cropFiles = subTitulo.listPhotosPath
          ?.map((dynamic element) {
            if (element is CroppedFile) return element;
          })
          .whereType<CroppedFile>()
          .toList();

      urlFotografias = await uploadFiles(cropFiles!);
      subTitulo.listPhotosPath?.clear();
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
