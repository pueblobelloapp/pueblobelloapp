import 'dart:async';
import 'package:app_turismo/Recursos/Models/PropietarioModel.dart';
import 'package:app_turismo/Recursos/Repository/RepositoryPropietarios.dart';
import 'package:app_turismo/main.dart';
import 'package:get/get.dart';

class PropietarioController extends GetxController {
  final MyPropietarioRepository _myPropietarioRepository = getIt();

  Propietario? _toEdit;
  Rx<bool> isLoading = Rx(false);

  Future<void> saveImageProfile() async {
    _myPropietarioRepository.saveImageProfile();
  }

  Future<void> savePropietario(
    String uidPropietario,
    String nombre,
    String rool,
    String edad,
    String genero,
    String correo,
    String contacto,
  ) async {
    isLoading.value = true;

    _toEdit = Propietario(
        id: uidPropietario,
        rool: rool,
        nombre: nombre,
        edad: edad,
        genero: genero,
        correo: correo,
        contacto: contacto,
        foto: _toEdit?.foto);

    await _myPropietarioRepository.saveMyPropietario(_toEdit!);
    isLoading.value = false;
  }

  Future<void> editSite(
    String uid,
    String rool,
    String nombre,
    String edad,
    String genero,
    String correo,
    String contacto,
  ) async {
    isLoading.value = true;

    _toEdit = Propietario(
        id: uid,
        rool: rool,
        nombre: nombre,
        edad: edad,
        genero: genero,
        correo: correo,
        contacto: contacto,
        foto: _toEdit?.foto);

    await _myPropietarioRepository.saveMyPropietario(_toEdit!);
    isLoading.value = false;
  }

  Future<void> informationUser() async {
    await _myPropietarioRepository.informationUser();
  }
}
