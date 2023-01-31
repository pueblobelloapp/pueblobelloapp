import 'package:app_turismo/Recursos/Controller/GextControllers/GexTurismo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../Paginas/Menu.dart';

class ControllerLogin extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  final GextControllerTurismo _controllerTurismo =
  Get.put(GextControllerTurismo());
  final editControlTurismo = Get.find<GextControllerTurismo>();

  final Rx<dynamic> _uid = "".obs;
  final Rx<dynamic> _email = "Sin Registro".obs;
  String _userRole = "false";

  String get uid => _uid.value;
  String get email => _email.value;
  String get userRole => _userRole;

  Future<void> getLogin(String e, String p) async {
    try {
      print("Iniciando Consulta de usuario");

      UserCredential user =
          await firebaseAuth.signInWithEmailAndPassword(email: e, password: p);
      _uid.value = user.user!.uid;
      _email.value = user.user!.email;

      print("Marcando usuario");
      editControlTurismo.updateUidUserLogin(_uid.value);

      print("Consultado Roles: " + uid);
      final snapshot= await FirebaseFirestore.instance.collection('propietario').doc(uid).get();
      Map<String, dynamic> data = snapshot.data()!;

      data['rool'] == 'Propietario' ? _userRole = "true" : _userRole = "false";
      print("Rol asiganado: " + _userRole);
      update();

    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        print("user-not-found" + e.code);
        return Future.error('Usuario no Existe');
      } else if (e.code == 'wrong-password') {
        print("Contraseña incorrecta" + e.code);
        return Future.error('Contraseña incorrecta');
      }
    }
  }

  Future<void> signOut() async {}

  static Future<User?> singUpUsingEmailAndPass({
    required String name,
    required String email,
    required String pass,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: pass);

      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('Advertencia: Contraseña débil'); //('Warning: Weak password')
      } else if (e.code == 'email-already-in-use') {
        print('Error: Correo electrónico ya en uso'); //('Email already in use')
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

}
