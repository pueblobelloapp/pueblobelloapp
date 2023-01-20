import 'package:equatable/equatable.dart';

class Propietario extends Equatable {
  final String id;
  final String nombre;
  final String sitioturistico;
  final String edad;
  final String genero;
  final String correo;
  final String contacto;
  final String clave;
  final String? foto;

  const Propietario(
      {required this.id,
      required this.nombre,
      required this.sitioturistico,
      required this.edad,
      required this.genero,
      required this.correo,
      required this.contacto,
        required this. clave,
      this.foto});

  @override
  // TODO: implement props
  List<Object?> get props => [id, nombre, sitioturistico, edad, genero, correo, contacto, clave];

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'id': id,
      'nombre': nombre,
      'sitioturistico': sitioturistico,
      'edad': edad,
      'genero': genero,
      'correo': correo,
      'contacto' : contacto,
      'clave' : clave,
      'foto' : foto
    };
  }

  Propietario.fromFirebaseMap(Map<String, Object?> data)
      : id = data['id'] as String,
        nombre = data['nombre'] as String,
        sitioturistico = data['sitioturistico'] as String,
        edad = data['edad'] as String,
        genero = data['genero'] as String,
        correo = data['correo'] as String,
        contacto = data['contacto'] as String,
        clave = data['clave'] as String,
        foto = data['foto'] as String?;

  Propietario copyWith({
    String? id,
    String? nombre,
    String? sitioturistico,
    String? edad,
    String? genero,
    String? correo,
    String? contacto,
    String? clave,
    String? foto,
  }) {
    return Propietario(id : id ?? this.id,
        nombre: nombre ?? this.nombre,
        sitioturistico : sitioturistico ?? this.sitioturistico,
        edad : edad ?? this.edad,
        genero : genero ?? this.genero,
        correo : correo ?? this.correo,
        contacto : contacto ?? this.contacto,
        clave : clave ?? this.clave,
        foto : foto ?? this.foto);
  }

}
