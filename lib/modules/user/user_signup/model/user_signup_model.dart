import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataModel {
  String? uId;
  String email;
  String username;
  String phoneNumber;
  String password;
  String referredBy;
  String referredByUserAmountAdded;
  DateTime? createdAt;
  String? profileImage;
  num? userBalance;
  String? gender;
  String? city;
  String? state;
  String? panNumber;
  List<UserBankData>? userBanksDataList;

  UserDataModel({
    this.uId,
    required this.email,
    required this.username,
    required this.phoneNumber,
    required this.password,
    required this.referredBy,
    required this.referredByUserAmountAdded,
    this.createdAt,
    this.profileImage,
    this.userBalance,
    this.gender,
    this.city,
    this.state,
    this.panNumber,
    this.userBanksDataList,
  });

  UserDataModel copyWith({
    String? newProfileImage,
    String? newUserName,
    String? newPassword,
    String? newPhoneNumber,
    DateTime? newCreatedAt,
    num? newUserBalance,
    String? newGender,
    String? newCity,
    String? newState,
    String? newPanNumber,
    String? newReferredByUserAmountAdded,
    List<UserBankData>? newUserBanksDataList,
  }) {
    return UserDataModel(
      email: email,
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
      referredBy: referredBy,
      userBanksDataList: newUserBanksDataList ?? userBanksDataList,
      referredByUserAmountAdded: newReferredByUserAmountAdded ?? referredByUserAmountAdded,
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
      'referredBy': referredBy,
      'referredByUserAmountAdded': referredByUserAmountAdded,
      'userBanksDataList': userBanksDataList?.map((bankData) => bankData.toMap()).toList() ?? [],
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
      referredBy: map['referredBy'],
      referredByUserAmountAdded: map['referredByUserAmountAdded'],
      userBanksDataList: List<UserBankData>.from(map['userBanksDataList']?.map((bankData) => UserBankData.fromMap(bankData)) ?? []),
    );
  }
}

class UserBankData {
  String bankName;
  String ifscCode;
  String accNumber;
  String accHolderName;

  UserBankData({required this.bankName, required this.ifscCode, required this.accNumber, required this.accHolderName});

  Map<String, dynamic> toMap() {
    return {
      'bankName': bankName,
      'ifscCode': ifscCode,
      'accNumber': accNumber,
      'accHolderName': accHolderName,
    };
  }

  factory UserBankData.fromMap(Map<String, dynamic> map) {
    return UserBankData(
      bankName: map['bankName'],
      ifscCode: map['ifscCode'],
      accNumber: map['accNumber'],
      accHolderName: map['accHolderName'],
    );
  }
}
