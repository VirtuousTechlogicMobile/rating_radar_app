import 'package:cloud_firestore/cloud_firestore.dart';

class UserTransactionModel {
  String? transactionDocId;
  String? submittedAdDocId;
  String uId;
  String transactionType;
  String transactionId;
  String status;
  DateTime date;
  num amount;

  UserTransactionModel({
    this.transactionDocId,
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
      transactionDocId: transactionDocId,
      submittedAdDocId: submittedAdDocId,
      uId: map['uId'] as String,
      transactionType: map['transactionType'] as String,
      transactionId: map['transactionId'] as String,
      status: map['status'] as String,
      date: (map['date'] as Timestamp).toDate(),
      amount: map['amount'] as num,
    );
  }
}
