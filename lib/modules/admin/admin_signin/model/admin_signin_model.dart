class AdminSignInModel {
  String email;
  String password;

  AdminSignInModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }
}
