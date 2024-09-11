import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataModel {
  String email;
  String username;
  String phoneNumber;
  String password;
  DateTime? createdAt;
  String? profileImage;
  num? userBalance;

  UserDataModel({
    required this.email,
    required this.username,
    required this.phoneNumber,
    required this.password,
    this.createdAt,
    this.profileImage,
    this.userBalance,
  });

  UserDataModel copyWith({
    String? newProfileImage,
    String? newUserName,
    String? newEmail,
    String? newPassword,
    String? newPhoneNumber,
    DateTime? newCreatedAt,
    num? newUserBalance,
  }) {
    return UserDataModel(
      email: newEmail ?? email,
      password: newPassword ?? password,
      phoneNumber: newPhoneNumber ?? phoneNumber,
      createdAt: newCreatedAt ?? createdAt,
      userBalance: newUserBalance ?? userBalance,
      profileImage: newProfileImage ?? profileImage,
      username: newUserName ?? username,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      'phoneNumber': phoneNumber,
      'password': password,
      'createdAt': createdAt,
      'profileImage': profileImage,
      'userBalance': userBalance,
    };
  }

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      email: map['email'],
      password: map['password'],
      username: map['username'],
      phoneNumber: map['phoneNumber'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      profileImage: map['profileImage'],
      userBalance: map['userBalance'],
    );
  }
}
