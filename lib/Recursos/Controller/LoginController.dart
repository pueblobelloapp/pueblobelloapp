import 'package:app_turismo/Recursos/Controller/GextControllers/GextPropietarioController.dart';
import 'package:app_turismo/Recursos/Controller/GextControllers/GetxManagementTouristSite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'GextControllers/GextUtils.dart';

class ControllerLogin extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  final GetxUtils messageController = Get.put(GetxUtils());

  final Rx<dynamic> _uid = "".obs;
  final Rx<dynamic> _email = "Sin Registro".obs;
  String _userRole = "false";
  Map<String, dynamic> _dataUsuario = {};

  String get uid => _uid.value;
  String get email => _email.value;
  String get userRole => _userRole;
  Map<String, dynamic> get dataUsuario => _dataUsuario;

  void updateDataUsuario(Map<String, dynamic> userUpdate) {
    _dataUsuario = userUpdate;
    update();
  }

  Future<void> getLogin(String e, String p) async {
    try {
      UserCredential user =
          await firebaseAuth.signInWithEmailAndPassword(email: e, password: p);
      _uid.value = user.user!.uid;
      _email.value = user.user!.email;

      final snapshot = await FirebaseFirestore.instance
          .collection('propietario')
          .doc(uid)
          .get()
          .then((value) {
        _dataUsuario = value.data()!;
        
        final bool estado = _dataUsuario['estado'] ?? false;
        if (!estado && (_dataUsuario['rool'] == 'Propietario')) {
          throw "not-privilegio";
        }

        _dataUsuario['rool'] == 'Propietario'
            ? _userRole = "true"
            : _userRole = "false";

        update();
      }).catchError((onError) {
        print("Se genero un error: " + onError);
        throw "not-privilegio";
      });
    } on FirebaseException catch (e) {
      print("Error: ? " + e.toString());
      if (e.code == 'user-not-found') {
        return Future.error('user-not-found');
      } else if (e.code == "network-request-failed") {
        print("Error con la red." + e.code);
        return Future.error('network-request-failed');
      } else if (e.code == 'wrong-password') {
        print("Contraseña incorrecta" + e.code);
        return Future.error('wrong-password');
      }
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future recuperarPassword(String correo) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: correo);
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'user-not-found') {
        return Future.error('user-not-found');
      } else if (e.code == "invalid-email") {
        return Future.error('invalid-email');
      } else {
        return Future.error(e.code.toString());
      }
    }
  }
}
