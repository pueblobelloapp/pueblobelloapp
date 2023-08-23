import 'package:app_turismo/Recursos/Models/SubInfoMunicipio.dart';
import 'package:equatable/equatable.dart';

class InfoMunicipio extends Equatable{
  final String id;
  final String nombre;
  final String descripcion;
  final String ubicacion;
  final List<String>? foto;
  final List<SubInfoMunicipio> subTitulos;

  const InfoMunicipio({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.ubicacion,
    required this.subTitulos,
    this.foto
  });

  @override
  List<Object?> get props => [id, nombre, descripcion, ubicacion, foto, subTitulos];

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'ubicacion': ubicacion,
      'foto' : foto,
      'subtitulo' : subTitulos
    };
  }

  InfoMunicipio.fromFirebaseMap(Map<String, Object?> data)
      : id = data['id'] as String,
        nombre = data['nombre'] as String,
        descripcion = data['descripcion'] as String,
        ubicacion = data['ubicacion'] as String,
        foto = data['foto'] as  List<String>?,
        subTitulos = data['subtitulos'] as List<SubInfoMunicipio>;

  InfoMunicipio copyWith({
    String? id,
    String? nombre,
    String? capacidad,
    String? tipoTurismo,
    String? descripcion,
    String? ubicacion,
    List<String>? foto,
    List<SubInfoMunicipio>? subTitulos
  }) {
    return InfoMunicipio(id : id ?? this.id,
        nombre: nombre ?? this.nombre,
        descripcion : descripcion ?? this.descripcion,
        ubicacion : ubicacion ?? this.ubicacion,
        foto : foto ?? this.foto,
        subTitulos : subTitulos ?? this.subTitulos);
  }
}
