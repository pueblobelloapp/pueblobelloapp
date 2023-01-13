import 'dart:io';
import 'package:app_turismo/Recursos/Models/SiteTuristico.dart';

abstract class MySitesRepository {

  String newId();
  Stream<Iterable<SitioTuristico>> getMySite();
  Future<void> saveMySite(SitioTuristico mySite, File? image);
  Future<void> editMySite(SitioTuristico mySite, File? image);
  Future<void> deleteMySite(SitioTuristico mySite);

}
