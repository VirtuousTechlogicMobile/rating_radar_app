import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataModel {
  String? uId;
  String email;
  String username;
  String phoneNumber;
  String password;
  String referredBy;
  DateTime? createdAt;
  String? profileImage;
  num? userBalance;
  String? gender;
  String? city;
  String? state;
  String? panNumber;
  String type;
  List<UserCardData>? userCardsList;
  List<UserBankData>? userBanksDataList;

  UserDataModel({
    this.uId,
    required this.email,
    required this.username,
    required this.phoneNumber,
    required this.password,
    required this.referredBy,
    required this.type,
    this.createdAt,
    this.profileImage,
    this.userBalance,
    this.gender,
    this.city,
    this.state,
    this.panNumber,
    this.userCardsList,
    this.userBanksDataList,
  });

  UserDataModel copyWith({
    DateTime? newCreatedAt,
    String? newProfileImage,
    String? newUserName,
    String? newPassword,
    String? newPhoneNumber,
    num? newUserBalance,
    String? newGender,
    String? newCity,
    String? newState,
    String? newPanNumber,
    List<UserCardData>? newUserCardsList,
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
      userCardsList: newUserCardsList ?? userCardsList,
      type: type,
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
      'userBanksDataList':
          userBanksDataList?.map((bankData) => bankData.toMap()).toList() ?? [],
      'userCardsList':
          userCardsList?.map((cardData) => cardData.toMap()).toList() ?? [],
      "type": type,
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
      userBanksDataList: List<UserBankData>.from(map['userBanksDataList']
              ?.map((bankData) => UserBankData.fromMap(bankData)) ??
          []),
      userCardsList: List<UserCardData>.from(map['userCardsList']
              ?.map((cardData) => UserCardData.fromMap(cardData)) ??
          []),
      type: map['type'],
    );
  }
}

class UserCardData {
  String holderName;
  DateTime expDate;
  String cvv;
  String cardNumber;

  UserCardData(
      {required this.holderName,
      required this.expDate,
      required this.cvv,
      required this.cardNumber});

  Map<String, dynamic> toMap() {
    return {
      'holderName': holderName,
      'expDate': expDate,
      'cvv': cvv,
      'cardNumber': cardNumber,
    };
  }

  factory UserCardData.fromMap(Map<String, dynamic> map) {
    return UserCardData(
      holderName: map['holderName'],
      expDate: map['expDate'],
      cvv: map['cvv'],
      cardNumber: map['cardNumber'],
    );
  }
}

class UserBankData {
  String bankName;
  String ifscCode;
  String accNumber;
  String accHolderName;

  UserBankData(
      {required this.bankName,
      required this.ifscCode,
      required this.accNumber,
      required this.accHolderName});

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
