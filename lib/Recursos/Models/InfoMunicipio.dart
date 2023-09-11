class InfoMunicipio {
  late final String id;
  final String nombre;
  final String descripcion;
  final String subCategoria;
  late Ubicacion? ubicacion;
  late List<dynamic>? photos;
  final List<SubTitulo> subTitulos;

  InfoMunicipio({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.subCategoria,
    this.ubicacion,
    this.photos,
    required this.subTitulos,
  });

  InfoMunicipio copyWith({
    String? id,
    String? nombre,
    String? descripcion,
    String? subCategoria,
    Ubicacion? ubicacion,
    List<dynamic>? photos,
    List<SubTitulo>? subTitulos,
  }) =>
      InfoMunicipio(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        descripcion: descripcion ?? this.descripcion,
        subCategoria: subCategoria ?? this.subCategoria,
        ubicacion: ubicacion ?? this.ubicacion,
        photos: photos ?? this.photos,
        subTitulos: subTitulos ?? this.subTitulos,
      );

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'subCategoria': subCategoria,
      'ubicacion': ubicacion?.toFirebaseMap(),
      'photos': photos,
      'subTitulos': subTitulos.map((subTitulo) => subTitulo.toFirebaseMap()).toList(),
    };
  }

  factory InfoMunicipio.fromFirebaseMap(Map<String, Object?> data) {
    return InfoMunicipio(
      id: data['id'] as String,
      nombre: data['nombre'] as String,
      descripcion: data['descripcion'] as String,
      subCategoria: data['subCategoria'] as String,
      ubicacion: Ubicacion.fromFirebaseMap(data['ubicacion'] as Map<String, Object?>),
      photos: (data['photos'] as List<dynamic>),
      subTitulos: (data['subTitulos'] as List<dynamic>).map((subTituloData) => SubTitulo.fromFirebaseMap(subTituloData as Map<String, Object?>)).toList(),
    );
  }

}

class SubTitulo {
  final String titulo;
  final String descripcion;
  late List<dynamic>? listPhotosPath;

  SubTitulo({
    required this.titulo,
    required this.descripcion,
    this.listPhotosPath,
  });

  SubTitulo copyWith({
    String? titulo,
    String? descripcion,
    List<dynamic>? listPhotosPath,
  }) =>
      SubTitulo(
        titulo: titulo ?? this.titulo,
        descripcion: descripcion ?? this.descripcion,
        listPhotosPath: listPhotosPath ?? this.listPhotosPath,
      );

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'titulo': titulo,
      'descripcion': descripcion,
      'listPhotos': listPhotosPath,
    };
  }

  factory SubTitulo.fromFirebaseMap(Map<String, Object?> data) {
    return SubTitulo(
      titulo: data['titulo'] as String,
      descripcion: data['descripcion'] as String,
      listPhotosPath: data['listPhotos'] as List<dynamic>);
  }
}

class Ubicacion {
  final String lat;
  final String long;

  Ubicacion({
    required this.lat,
    required this.long,
  });

  Ubicacion copyWith({
    String? lat,
    String? long,
  }) =>
      Ubicacion(
        lat: lat ?? this.lat,
        long: long ?? this.long,
      );

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'lat': lat,
      'long': long,
    };
  }

  factory Ubicacion.fromFirebaseMap(Map<String, Object?> data) {
    return Ubicacion(
      lat: data['lat'] as String,
      long: data['long'] as String,
    );
  }
}
