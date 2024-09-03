class UserSubmittedAdsListDataModel {
  String submittedAdDocId;
  String adId;
  String taskName;
  String company;
  String email;
  DateTime date;
  num adPrice;
  String adStatus;

  UserSubmittedAdsListDataModel({
    required this.submittedAdDocId,
    required this.adId,
    required this.taskName,
    required this.company,
    required this.email,
    required this.date,
    required this.adPrice,
    required this.adStatus,
  });

  factory UserSubmittedAdsListDataModel.fromMap(Map<String, dynamic> map, {String? adDocId}) {
    var userAdsListDataModel = UserSubmittedAdsListDataModel(
      submittedAdDocId: map['adDocId'] as String,
      adId: map['adId'] as String,
      taskName: map['userName'] as String,
      company: map['company'] as String,
      email: map['email'] as String,
      date: map['date'] as DateTime,
      adPrice: map['adPrice'] as num,
      adStatus: map['adStatus'] as String,
    );
    return userAdsListDataModel;
  }
}
