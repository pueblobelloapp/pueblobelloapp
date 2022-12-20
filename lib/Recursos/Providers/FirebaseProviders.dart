import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Models/Users.dart';

class FirebaseProvider {
  User get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("No Autenticado exection");
    return user;
  }

  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  FirebaseFirestore get storage => FirebaseFirestore.instance;

  //Funcion para leer un usuario.
  Future<MyUsers?> getMyUser() async {
    final snapshot = await firestore.doc('user/${currentUser.uid}').get();
    print("Contenido del snapsot");
    print(snapshot);
    if (snapshot.exists) return MyUsers.fromFirebaseMap(snapshot.data()!);
    return null;
  }

  // Creates or updates a document in myUser collection. If image is not null
  // it will create or update the image in Firebase Storage
  Future<void> saveMyUser(MyUsers myUser) async {
    final ref = firestore.doc('user/${currentUser.uid}/myUsers/${myUser.id}');
    print("Hola");
    await ref.set(myUser.toFirebaseMap(), SetOptions(merge: true));
  }
}
