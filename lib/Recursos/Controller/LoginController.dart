import 'package:app_turismo/Recursos/Controller/GextControllers/GexTurismo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ControllerLogin extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  final GextControllerTurismo _controllerTurismo =
  Get.put(GextControllerTurismo());
  //final editControlTurismo = Get.find<GextControllerTurismo>();

  final Rx<dynamic> _uid = "".obs;
  final Rx<dynamic> _email = "Sin Registro".obs;
  String _userRole = "false";
  Map<String, dynamic> _dataUsuario = {};


  String get uid => _uid.value;
  String get email => _email.value;
  String get userRole => _userRole;
  Map<String, dynamic> get dataUsuario => _dataUsuario;

  void updateDataUsuario( Map<String, dynamic> userUpdate ) {
   _dataUsuario = userUpdate;
   update();
  }

  Future<void> getLogin(String e, String p) async {
    try {
      UserCredential user =
          await firebaseAuth.signInWithEmailAndPassword(email: e, password: p);
      _uid.value = user.user!.uid;
      _email.value = user.user!.email;

      _controllerTurismo.updateUidUserLogin(_uid.value);

      final snapshot = await FirebaseFirestore.instance
          .collection('propietario').doc(uid).get()
          .then((value) {
              _dataUsuario = value.data()!;
              _dataUsuario['rool'] == 'Propietario' ?
                              _userRole = "true" : _userRole = "false";
              update();
          }).catchError((onError) {
            print("Se genero un error: " + onError);
      });

    } on FirebaseException catch (e) {
      print("Error: ? " + e.toString());
      if (e.code == 'user-not-found') {
        return Future.error('user-not-found');
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
