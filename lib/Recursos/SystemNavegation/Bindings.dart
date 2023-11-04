
import 'package:app_turismo/Recursos/Controller/GextControllers/GetxConnectivity.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GetxInformationMunicipio.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GetxManagementMunicipality.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GetxManagementTouristSite.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GextUtils.dart';
import 'package:app_turismo/Recursos/Controller/LoginController.dart';
import 'package:app_turismo/Recursos/Paginas/modulopages/ImageUpload.dart';
import 'package:get/get.dart';

class MunicipalityBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ManagementMunicipalityController(), permanent: true);
  }
}

class RouristSiteBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(GetxManagementTouristSite(), permanent:  true);
  }
}

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ControllerLogin(), permanent:  true);
  }
}

class RegisterSitesBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(GetxManagementTouristSite(), permanent: true);
  }
}

class UtilGetxBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(GetxUtils(), permanent: true);
  }
}

class ImageUploadBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ImageUpload(), permanent: true);
  }
}


class InformationMunicipalityBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(GetxInformationMunicipio(), permanent: true);
  }
}

class ConnectivityBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ConnectivityController(), permanent: true);
  }
}