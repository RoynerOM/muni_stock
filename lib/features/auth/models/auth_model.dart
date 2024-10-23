class AuthModel {
  String nombre;
  String email;
  String password;
  String rol;
  String? token;
  AuthModel({
    required this.nombre,
    required this.email,
    required this.password,
    required this.rol,
    this.token,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        nombre: json["nombre"],
        email: json["email"],
        password: json["password"],
        rol: json["rol"],
        token: json["token"],
      );

  Map<String, dynamic> toRegister() => {
        "nombre": nombre,
        "email": email,
        "password": password,
        "rol": rol,
      };

  Map<String, dynamic> toLogin() => {
        "email": email,
        "password": password,
      };
}
