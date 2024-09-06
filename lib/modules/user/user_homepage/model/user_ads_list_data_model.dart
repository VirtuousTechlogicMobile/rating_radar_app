import 'package:cloud_firestore/cloud_firestore.dart';

class UserAdsListDataModel {
  String? docId;
  String adName;
  String adContent;
  String? adStatus;
  DateTime? addedDate;
  String byCompany;
  List<String>? imageUrl;
  num adPrice;

  UserAdsListDataModel({
    this.docId,
    required this.adName,
    required this.adContent,
    this.adStatus,
    this.addedDate,
    required this.byCompany,
    required this.imageUrl,
    required this.adPrice,
  });

  factory UserAdsListDataModel.fromMap(Map<String, dynamic> map,
      {String? docId}) {
    return UserAdsListDataModel(
      docId: docId,
      adName: map['adName'] as String,
      adPrice: map['adPrice'] as num,
      adStatus: map['adStatus'] as String,
      addedDate: map['addedDate'] != null
          ? (map['addedDate'] as Timestamp).toDate()
          : null,
      imageUrl: (map['adImageUrl'] as List<dynamic>?)?.cast<String>(),
      adContent: map['adContent'] as String,
      byCompany: map['byCompany'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'adName': adName,
      'adContent': adContent,
      'adStatus': adStatus,
      'addedDate': addedDate,
      'byCompany': byCompany,
      'addedDate': addedDate,
      'adPrice': adPrice,
    };
  }
}
