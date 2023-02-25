import 'package:equatable/equatable.dart';

class SitioTuristico extends Equatable{
  final String id;
  final String nombre;
  final String capacidad;
  final String tipoTurismo;
  final String descripcion;
  final String ubicacion;
  final String? userId;
  final List<dynamic>? foto;

  const SitioTuristico({
    required this.id,
    required this.nombre,
    required this.capacidad,
    required this.tipoTurismo,
    required this.descripcion,
    required this.ubicacion,
    required this.userId,
    this.foto
});

  @override
  // TODO: implement props
  List<Object?> get props => [id, nombre, capacidad, tipoTurismo, descripcion, ubicacion, userId, foto];

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'id': id,
      'nombre': nombre,
      'capacidad': capacidad,
      'tipoTurismo': tipoTurismo,
      'descripcion': descripcion,
      'ubicacion': ubicacion,
      'userId' : userId,
      'foto' : foto
    };
  }

  SitioTuristico.fromFirebaseMap(Map<String, Object?> data)
      : id = data['id'] as String,
        nombre = data['nombre'] as String,
        capacidad = data['capacidad'] as String,
        tipoTurismo = data['tipoTurismo'] as String,
        descripcion = data['descripcion'] as String,
        ubicacion = data['ubicacion'] as String,
        userId = data['userId'] as String?,
        foto = data['foto'] as List<String>?;



  SitioTuristico copyWith({
     String? id,
     String? nombre,
     String? capacidad,
     String? tipoTurismo,
     String? descripcion,
     String? ubicacion,
     String? userId,
     List<String>? foto,
}) {
    return SitioTuristico(
        id : id ?? this.id,
        nombre: nombre ?? this.nombre,
        capacidad : capacidad ?? this.capacidad,
        tipoTurismo : tipoTurismo ?? this.tipoTurismo,
        descripcion : descripcion ?? this.descripcion,
        ubicacion : ubicacion ?? this.ubicacion,
        userId : userId ?? this.userId,
        foto : foto ?? this.foto);
  }
}
