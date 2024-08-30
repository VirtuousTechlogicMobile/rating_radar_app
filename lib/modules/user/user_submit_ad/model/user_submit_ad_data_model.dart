import 'package:cloud_firestore/cloud_firestore.dart';

class UserSubmitAdDataModel {
  String? currentDocId;
  String adId;
  String uId;
  List<String>? imageList;
  DateTime addedDate;
  String comments;
  String status;
  String adName;
  String company;
  num adPrice;

  UserSubmitAdDataModel({
    this.currentDocId,
    required this.adId,
    required this.uId,
    this.imageList,
    required this.addedDate,
    required this.comments,
    required this.status,
    required this.adName,
    required this.company,
    required this.adPrice,
  });

  factory UserSubmitAdDataModel.fromMap(Map<String, dynamic> map, {String? submittedAdDocId}) {
    return UserSubmitAdDataModel(
      currentDocId: submittedAdDocId,
      adId: map['adId'] as String,
      uId: map['uId'] as String,
      status: map['status'] as String,
      comments: map['comments'] as String,
      adName: map['adName'] as String,
      company: map['company'] as String,
      adPrice: map['adPrice'] as num,
      addedDate: (map['addedDate'] as Timestamp).toDate(),
      imageList: (map['imageList'] as List<dynamic>?)?.cast<String>(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'adId': adId,
      'uId': uId,
      'imageList': imageList,
      'addedDate': addedDate,
      'comments': comments,
      'status': status,
      'adName': adName,
      'company': company,
      'adPrice': adPrice,
    };
  }
}
