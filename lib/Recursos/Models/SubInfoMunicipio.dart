import 'dart:convert';

import 'package:image_cropper/image_cropper.dart';

class SubInfoMunicipio {
  final String titulo;
  final String descripcion;
  final List<CroppedFile> listPhotosFiles;
  final List<String> listPhotosPath;
  SubInfoMunicipio({
    required this.titulo,
    required this.descripcion,
     required this.listPhotosFiles,
     required this.listPhotosPath,
  });

  SubInfoMunicipio copyWith({
    String? titulo,
    String? descripcion,
    required List<CroppedFile> listPhotos,
    required List<String> photos,
  }) {
    return SubInfoMunicipio(
      titulo: titulo ?? this.titulo,
      descripcion: descripcion ?? this.descripcion,
      listPhotosFiles: listPhotos ?? this.listPhotosFiles,
      listPhotosPath: photos ?? this.listPhotosPath,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'titulo': titulo,
      'descripcion': descripcion,
      'listPhotosFiles': listPhotosFiles,
      'listPhotosPaths': listPhotosPath,
    };
  }

  factory SubInfoMunicipio.fromMap(Map<String, dynamic> map) {
    return SubInfoMunicipio(
      titulo: map['titulo'] as String,
      descripcion: map['descripcion'] as String,
      listPhotosFiles: List<CroppedFile>.from((map['listPhotosFiles'] as List<CroppedFile>)),
      listPhotosPath: List<String>.from((map['listPhotosPaths'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory SubInfoMunicipio.fromJson(String source) =>
      SubInfoMunicipio.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SubInfoMunicipio(titulo: $titulo, descripcion: $descripcion, '
          'listPhotosFiles: $listPhotosFiles, listPhtosPaths: $listPhotosPath)';
}
