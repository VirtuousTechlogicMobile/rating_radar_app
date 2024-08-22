import 'package:cloud_firestore/cloud_firestore.dart';

class AdminAdsListDataModel {
  String? docId;
  String adName;
  String adContent;
  String? adStatus;
  DateTime? addedDate;
  String byCompany;
  String imageUrl;
  num adPrice;

  AdminAdsListDataModel({
    this.docId,
    required this.adName,
    required this.adContent,
    this.adStatus,
    this.addedDate,
    required this.byCompany,
    required this.imageUrl,
    required this.adPrice,
  });

  factory AdminAdsListDataModel.fromMap(Map<String, dynamic> map,
      {String? docId}) {
    return AdminAdsListDataModel(
      docId: docId,
      adName: map['adName'] as String,
      adPrice: map['adPrice'] as num,
      adStatus: map['adStatus'] as String,
      addedDate: map['addedDate'] != null
          ? (map['addedDate'] as Timestamp).toDate()
          : null,
      imageUrl: map['adImageUrl'] as String,
      adContent: map['adContent'] as String,
      byCompany: map['byCompany'] as String,
    );
  }
}
