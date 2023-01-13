import 'package:app_turismo/Recursos/Repository/autenticacion.dart';
import 'package:firebase_auth/firebase_auth.dart';

typedef UserUID = String;

class AuthRepositoryImp extends AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<UserUID?> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().asyncMap((user) => user?.uid);
  }

  @override
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }
}
