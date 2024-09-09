import 'package:cloud_firestore/cloud_firestore.dart';

class AdminHomepageRecentUserCompanyModel {
  String? docId;
  String name;
  String email;
  String? imageUrl;
  DateTime? createdAt;

  AdminHomepageRecentUserCompanyModel({
    this.docId,
    required this.name,
    required this.email,
    this.imageUrl,
    this.createdAt,
  });

  factory AdminHomepageRecentUserCompanyModel.fromMap(Map<String, dynamic> map,
      {String? docId}) {
    return AdminHomepageRecentUserCompanyModel(
      docId: docId,
      imageUrl: map['profileImage'],
      email: map['email'] ?? 'unknown_email@example.com',
      name: map['username'] ?? 'Unknown Name',
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : null,
    );
  }
}
