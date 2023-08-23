// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class SubInfoMunicipio {
  final String titulo;
  final String descripcion;
  final List<String> listPhotos;
  SubInfoMunicipio({
    required this.titulo,
    required this.descripcion,
    required this.listPhotos,
  });

  SubInfoMunicipio copyWith({
    String? titulo,
    String? descripcion,
    List<String>? listPhotos,
  }) {
    return SubInfoMunicipio(
      titulo: titulo ?? this.titulo,
      descripcion: descripcion ?? this.descripcion,
      listPhotos: listPhotos ?? this.listPhotos,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'titulo': titulo,
      'descripcion': descripcion,
      'listPhotos': listPhotos,
    };
  }

  factory SubInfoMunicipio.fromMap(Map<String, dynamic> map) {
    return SubInfoMunicipio(
      titulo: map['titulo'] as String,
      descripcion: map['descripcion'] as String,
      listPhotos: List<String>.from((map['listPhotos'] as List<String>),
    ));
  }

  String toJson() => json.encode(toMap());

  factory SubInfoMunicipio.fromJson(String source) => SubInfoMunicipio.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SubInfoMunicipio(titulo: $titulo, descripcion: $descripcion, listPhotos: $listPhotos)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SubInfoMunicipio &&
      other.titulo == titulo &&
      other.descripcion == descripcion &&
      listEquals(other.listPhotos, listPhotos);
  }

  @override
  int get hashCode => titulo.hashCode ^ descripcion.hashCode ^ listPhotos.hashCode;
}
