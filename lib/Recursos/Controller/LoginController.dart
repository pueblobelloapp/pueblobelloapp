
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ControllerLogin extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final Rx<dynamic> _uid = "".obs;
  final Rx<dynamic> _email = "Sin Registro".obs;

  String get password => _uid.value;
  String get email => _email.value;

  Future<void> getLogin(String e, String p) async {
    try {

      UserCredential user =
        await firebaseAuth.signInWithEmailAndPassword(email: e, password: p);
      _uid.value = user.user!.uid;
      _email.value = user.user!.email;

    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        return Future.error('Usuario no Existe');
      } else if (e.code == 'wrong-password') {
        return Future.error('Contraseña incorrecta');
      }
    }
  }
}