class InfoMunicipio {
  late String? id;
  late String nombre;
  late String descripcion;
  late String subCategoria;
  late List<dynamic> photos;
  late final List<SubTitulo> subTitulos;

  InfoMunicipio({
    this.id,
    required this.nombre,
    required this.descripcion,
    required this.subCategoria,
    required this.photos,
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
        photos: photos ?? this.photos,
        subTitulos: subTitulos ?? this.subTitulos,
      );

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'subCategoria': subCategoria,
      'photos': photos,
      'subTitulos': subTitulos.map((subTitulo) => subTitulo.toFirebaseMap()).toList(),
    };
  }

  factory InfoMunicipio.fromFirebaseMap(Map<String, Object?> data) {
    return InfoMunicipio(
      id: data['id'] as String,
      nombre: data['nombre'] as String? ?? 'Sin identificar',
      descripcion: data['descripcion'] as String? ?? 'Sin determinar',
      subCategoria: data['subCategoria'] as String? ?? 'Sinespecificar',
      photos: (data['photos'] as List<dynamic>) ?? [],
      subTitulos: (data['subTitulos'] as List<dynamic>)
          .map((subTituloData) => SubTitulo.fromFirebaseMap(subTituloData as Map<String, Object?>))
          .toList(),
    );
  }
}

class SubTitulo {
  late String titulo;
  late String descripcion;
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
        titulo: data['titulo'] as String? ?? 'Sin definir',
        descripcion: data['descripcion'] as String? ?? 'Sin determinar',
        listPhotosPath: data['listPhotos'] as List<dynamic> ?? []);
  }
}

class Ubicacion {
  late String lat;
  late String long;

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
