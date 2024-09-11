import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataModel {
  String? uId;
  String email;
  String username;
  String phoneNumber;
  String password;
  DateTime? createdAt;
  String? profileImage;
  num? userBalance;
  String? gender;
  String? city;
  String? state;
  String? panNumber;

  UserDataModel({
    this.uId,
    required this.email,
    required this.username,
    required this.phoneNumber,
    required this.password,
    this.createdAt,
    this.profileImage,
    this.userBalance,
    this.gender,
    this.city,
    this.state,
    this.panNumber,
  });

  UserDataModel copyWith({
    String? newProfileImage,
    String? newUserName,
    String? newEmail,
    String? newPassword,
    String? newPhoneNumber,
    DateTime? newCreatedAt,
    num? newUserBalance,
    String? newGender,
    String? newCity,
    String? newState,
    String? newPanNumber,
  }) {
    return UserDataModel(
      email: newEmail ?? email,
      password: newPassword ?? password,
      phoneNumber: newPhoneNumber ?? phoneNumber,
      createdAt: newCreatedAt ?? createdAt,
      userBalance: newUserBalance ?? userBalance,
      profileImage: newProfileImage ?? profileImage,
      username: newUserName ?? username,
      gender: newGender ?? gender,
      city: newCity ?? city,
      panNumber: newPanNumber ?? panNumber,
      state: newState ?? state,
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
      'gender': gender,
      'city': city,
      'state': state,
      'panNumber': panNumber,
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
      gender: map['gender'],
      city: map['city'],
      state: map['state'],
      panNumber: map['panNumber'],
    );
  }
}
