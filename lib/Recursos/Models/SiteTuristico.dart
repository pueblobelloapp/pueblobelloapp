import 'package:equatable/equatable.dart';

class SitioTuristico extends Equatable {
  final String id;
  final String nombre;
  final String tipoTurismo;
  final String descripcion;
  final String ubicacion;
  final bool estado;
  final String? userId;
  final String? direccion;
  final List<dynamic>? contacto;
  final List<dynamic>? horarios;
  final List<dynamic>? puntuacion;
  final List<dynamic>? servicios;
  final List<dynamic>? foto;

  const SitioTuristico(
      {required this.id,
      required this.nombre,
      required this.estado,
      required this.tipoTurismo,
      required this.descripcion,
      required this.ubicacion,
      required this.userId,
      this.direccion,
      this.contacto,
      this.horarios,
      this.puntuacion,
      this.servicios,
      this.foto});

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        nombre,
        estado,
        tipoTurismo,
        descripcion,
        ubicacion,
        userId,
        direccion,
        contacto,
        horarios,
        puntuacion,
        servicios,
        foto
      ];

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'id': id,
      'nombre': nombre,
      'estado': estado,
      'tipoTurismo': tipoTurismo,
      'descripcion': descripcion,
      'ubicacion': ubicacion,
      'userId': userId,
      'direccion': direccion,
      'contacto': contacto,
      'horarios': horarios,
      'puntuacion': puntuacion,
      'servicios': servicios,
      'foto': foto
    };
  }

  SitioTuristico.fromFirebaseMap(Map<String, Object?> data)
      : id = data['id'] as String,
        nombre = data['nombre'] as String,
        estado = data['estado'] as bool,
        tipoTurismo = data['tipoTurismo'] as String,
        descripcion = data['descripcion'] as String,
        ubicacion = data['ubicacion'] as String,
        userId = data['userId'] as String?,
        direccion = data['direccion'] as String?,
        contacto = data['contacto'] as List<String>?,
        horarios = data['horario'] as List<String>?,
        puntuacion = data['puntuacion'] as List<String>?,
        servicios = data['servicios'] as List<String>?,
        foto = data['foto;'] as List<String>?;

  SitioTuristico copyWith(
      {String? id,
      String? nombre,
      bool? estado,
      String? tipoTurismo,
      String? tipoPropiedad,
      String? descripcion,
      String? ubicacion,
      String? userId,
      String? direccion,
      List<String>? contacto,
      List<String>? horarios,
      List<String>? puntuacion,
      List<String>? servicios,
      List<String>? foto}) {
    return SitioTuristico(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      estado: estado ?? this.estado,
      tipoTurismo: tipoTurismo ?? this.tipoTurismo,
      descripcion: descripcion ?? this.descripcion,
      ubicacion: ubicacion ?? this.ubicacion,
      userId: userId ?? this.userId,
      contacto: contacto ?? this.contacto,
      horarios: horarios ?? this.horarios,
      puntuacion: puntuacion ?? this.puntuacion,
      servicios: servicios ?? this.servicios,
      foto: foto ?? this.foto,
    );
  }
}
