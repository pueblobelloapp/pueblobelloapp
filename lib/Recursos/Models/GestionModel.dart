import 'package:equatable/equatable.dart';

class GestionModel extends Equatable{
  final String id;
  final String nombre;
  final String descripcion;
  final String ubicacion;
  final String? foto;

  const GestionModel({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.ubicacion,
    this.foto
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, nombre, descripcion, ubicacion, foto];

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'ubicacion': ubicacion,
      'foto' : foto
    };
  }

  GestionModel.fromFirebaseMap(Map<String, Object?> data)
      : id = data['id'] as String,
        nombre = data['nombre'] as String,
        descripcion = data['descripcion'] as String,
        ubicacion = data['ubicacion'] as String,
        foto = data['foto'] as String?;

  GestionModel copyWith({
    String? id,
    String? nombre,
    String? capacidad,
    String? tipoTurismo,
    String? descripcion,
    String? ubicacion,
    String? foto,
  }) {
    return GestionModel(id : id ?? this.id,
        nombre: nombre ?? this.nombre,
        descripcion : descripcion ?? this.descripcion,
        ubicacion : ubicacion ?? this.ubicacion,
        foto : foto ?? this.foto);
  }
}
