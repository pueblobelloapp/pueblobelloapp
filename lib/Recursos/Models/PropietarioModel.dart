import 'package:equatable/equatable.dart';

class Propietario extends Equatable {
  final String id;
  final String rool;
  final String nombre;
  final String edad;
  final String genero;
  final String correo;
  final String contacto;
  final String? foto;

  const Propietario({
      required this.id,
      required this.rool,
      required this.nombre,
      required this.edad,
      required this.genero,
      required this.correo,
      required this.contacto,
      this.foto});

  @override
  List<Object?> get props => [id, rool, nombre, edad, genero, correo, contacto];

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'id': id,
      'rool' : rool,
      'nombre': nombre,
      'edad': edad,
      'genero': genero,
      'correo': correo,
      'contacto' : contacto,
      'foto' : foto
    };
  }

  Propietario.fromFirebaseMap(Map<String, Object?> data)
      : id = data['id'] as String,
        rool = data['rool'] as String,
        nombre = data['nombre'] as String,
        edad = data['edad'] as String,
        genero = data['genero'] as String,
        correo = data['correo'] as String,
        contacto = data['contacto'] as String,
        foto = data['foto'] as String?;

  Propietario copyWith({
    String? id,
    String? rool,
    String? nombre,
    String? edad,
    String? genero,
    String? correo,
    String? contacto,
    String? foto,
  }) {
    return Propietario(id : id ?? this.id,
        rool: rool ?? this.rool,
        nombre: nombre ?? this.nombre,
        edad : edad ?? this.edad,
        genero : genero ?? this.genero,
        correo : correo ?? this.correo,
        contacto : contacto ?? this.contacto,
        foto : foto ?? this.foto);
  }

}
