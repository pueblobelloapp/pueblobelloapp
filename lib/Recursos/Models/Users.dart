class MyUsers {
  final String id;
  final String nombre;
  final String apellido;
  final String correo;
  final String password;
  final String edad;
  final String telefono;
  final String estadoPropietario;
  final String typeUser;

  MyUsers(this.id, this.nombre, this.apellido, this.correo, this.password,
      this.edad, this.telefono, this.estadoPropietario, this.typeUser);

  Map<String, Object> toFirebaseMap() {
    return <String, Object> {
      'id' : id,
      'nombre' : nombre,
      'apellido' : apellido,
      'correo' : correo,
      'password' : password,
      'edad' : edad,
      'telefono' : telefono,
      'estadoPropietario' : estadoPropietario,
      'typeUser' : typeUser
    };
  }

  MyUsers.fromFirebaseMap(Map<String, Object?> data)
    : id = data['id'] as String,
      nombre = data['nombre']  as String,
      apellido = data['apellido'] as String,
      correo = data['correo'] as String,
      password = data['password'] as String,
      edad = data['edad'] as String,
      telefono = data['telefono'] as String,
      estadoPropietario = data['estadoPropietario'] as String,
      typeUser = data['typeUser'] as String;
}