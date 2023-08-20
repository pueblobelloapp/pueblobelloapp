import 'package:equatable/equatable.dart';

import 'Puntuacion.dart';

class SitioTuristico extends Equatable {
  final String id;
  final String nombre;
  final String tipoTurismo;
  final String descripcion;
  final Map<String, String>? ubicacion;
  final String? userId;
  final Map<String, String>? contacto;
  final List<Puntuacion>? puntuacion;
  final String? actividades;
  final List<dynamic>? foto;

  const SitioTuristico(
      {required this.id,
      required this.nombre,
      required this.tipoTurismo,
      required this.descripcion,
      required this.ubicacion,
      this.userId,
      required this.contacto,
      this.puntuacion,
      required this.actividades,
      this.foto});

  @override
  List<Object?> get props => [
        id,
        nombre,
        tipoTurismo,
        descripcion,
        ubicacion,
        userId,
        contacto,
        puntuacion,
        actividades,
        foto
      ];

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'id': id,
      'nombre': nombre,
      'tipoTurismo': tipoTurismo,
      'descripcion': descripcion,
      'ubicacion': ubicacion,
      'userId': userId,
      'contacto': contacto,
      'puntuacion': puntuacion,
      'actividades': actividades,
      'foto': foto
    };
  }

  SitioTuristico.fromFirebaseMap(Map<String, Object?> data)
      : id = data['id'] as String,
        nombre = data['nombre'] as String,
        tipoTurismo = data['tipoTurismo'] as String,
        descripcion = data['descripcion'] as String,
        ubicacion = data['ubicacion'] as Map<String, String>?,
        userId = data['userId'] as String?,
        contacto = data['contacto'] as Map<String, String>?,
        puntuacion = data['puntuacion'] as List<Puntuacion>?,
        actividades = data['actividades'] as String?,
        foto = data['foto;'] as List<String>?;

  SitioTuristico copyWith(
      {String? id,
      String? nombre,
      String? tipoTurismo,
      String? tipoPropiedad,
      String? descripcion,
      Map<String, String>? ubicacion,
      String? userId,
      Map<String, String>? contacto,
      List<Puntuacion>? puntuacion,
      String? actividades,
      List<String>? foto}) {
    return SitioTuristico(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      tipoTurismo: tipoTurismo ?? this.tipoTurismo,
      descripcion: descripcion ?? this.descripcion,
      ubicacion: ubicacion ?? this.ubicacion,
      userId: userId ?? this.userId,
      contacto: contacto ?? this.contacto,
      puntuacion: puntuacion ?? this.puntuacion,
      actividades: actividades ?? this.actividades,
      foto: foto ?? this.foto,
    );
  }
}
