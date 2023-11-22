class Puntuacion {
  String comentario;
  int calificacion;
  String uid;

  Puntuacion({this.comentario = '', this.calificacion = 0, this.uid = ''});

  Map<String, Object> toFirebaseMap() {
    return <String, Object>{
      "comentario": comentario,
      "calificacion": calificacion,
      "uid": uid
    };
  }
}
