import 'package:cloud_firestore/cloud_firestore.dart';

class UserTransactionModel {
  String? transactionCollectionDocId;
  String? submittedAdDocId;
  String uId;
  String transactionType;
  String transactionId;
  String status;
  DateTime date;
  num amount;

  UserTransactionModel({
    this.transactionCollectionDocId,
    this.submittedAdDocId,
    required this.uId,
    required this.transactionType,
    required this.transactionId,
    required this.status,
    required this.date,
    required this.amount,
  });

  factory UserTransactionModel.fromMap(Map<String, dynamic> map, {String? transactionDocId, String? submittedAdDocId}) {
    return UserTransactionModel(
      transactionCollectionDocId: transactionDocId,
      submittedAdDocId: submittedAdDocId,
      uId: map['uId'] as String,
      transactionType: map['transactionType'] as String,
      transactionId: map['transactionId'] as String,
      status: map['status'] as String,
      date: (map['date'] as Timestamp).toDate(),
      amount: map['amount'] as num,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'transactionType': transactionType,
      'transactionId': transactionId,
      'status': status,
      'date': date,
      'amount': amount,
    };
  }
}
