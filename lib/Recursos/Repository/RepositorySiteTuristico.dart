import 'package:app_turismo/Recursos/Models/SiteTuristico.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MySitesRepository {
  String newId();
  Stream<Iterable<SitioTuristico>> getMySite();
  Stream<QuerySnapshot> getSitesUid();
  Future<void> saveMySite(SitioTuristico mySite);
  Future<void> editMySite(SitioTuristico mySite);
  Future<void> deleteMySite(SitioTuristico mySite);
  Stream<QuerySnapshot> getAvtivity();
}
