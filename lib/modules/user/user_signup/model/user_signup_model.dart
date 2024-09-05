class UserSignupModel {
  String email;
  String username;
  String phoneNumber;
  String password;
  String? createdAt;
  String? profileImage;
  String? userBalance;

  UserSignupModel({
    required this.email,
    required this.username,
    required this.phoneNumber,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      'phoneNumber': phoneNumber,
      'password': password,
    };
  }

  factory UserSignupModel.fromMap(Map<String, dynamic> map) {
    return UserSignupModel(
      email: map['email'],
      username: map['username'],
      phoneNumber: map['phoneNumber'],
      password: map['password'],
    );
  }
}
