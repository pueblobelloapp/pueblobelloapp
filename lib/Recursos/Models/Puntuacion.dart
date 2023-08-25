class Puntuacion {
  String descripcion;
  int estrellas;
  String userId;

  Puntuacion({this.descripcion = '', this.estrellas = 0, this.userId = ''});

  Map<String, Object> toFirebaseMap() {
    return <String, Object>{
      "descripcion": descripcion,
      "estrellas": estrellas,
      "userId": userId
    };
  }
}
