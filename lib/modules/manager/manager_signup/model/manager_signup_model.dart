class ManagerSignupModel {
  String email;
  String username;
  String phoneNumber;
  String managerId;
  String password;

  ManagerSignupModel({
    required this.email,
    required this.username,
    required this.phoneNumber,
    required this.managerId,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      'phoneNumber': phoneNumber,
      'managerId': managerId,
      'password': password,
    };
  }

  factory ManagerSignupModel.fromMap(Map<String, dynamic> map) {
    return ManagerSignupModel(
      email: map['email'],
      username: map['username'],
      phoneNumber: map['phoneNumber'],
      managerId: map['managerId'],
      password: map['password'],
    );
  }
}
