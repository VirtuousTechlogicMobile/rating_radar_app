class UserSubmittedAdsListDataModel {
  String submittedAdId;
  String userName;
  String company;
  String email;
  DateTime date;
  num taskPrice;
  String adStatus;

  UserSubmittedAdsListDataModel({
    required this.submittedAdId,
    required this.userName,
    required this.company,
    required this.email,
    required this.date,
    required this.taskPrice,
    required this.adStatus,
  });

  factory UserSubmittedAdsListDataModel.fromMap(Map<String, dynamic> map, {String? adDocId}) {
    var userAdsListDataModel = UserSubmittedAdsListDataModel(
      submittedAdId: map['adDocId'] as String,
      userName: map['userName'] as String,
      company: map['company'] as String,
      email: map['email'] as String,
      date: map['date'] as DateTime,
      taskPrice: map['taskPrice'] as num,
      adStatus: map['adStatus'] as String,
    );
    return userAdsListDataModel;
  }
}
