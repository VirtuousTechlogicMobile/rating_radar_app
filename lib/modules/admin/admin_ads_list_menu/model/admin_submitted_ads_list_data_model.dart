class AdminSubmittedAdsListDataModel {
  String submittedAdDocId;
  String adId;
  String taskName;
  String byCompany;
  String email;
  DateTime date;
  num adPrice;
  String adStatus;

  AdminSubmittedAdsListDataModel({
    required this.submittedAdDocId,
    required this.adId,
    required this.taskName,
    required this.byCompany,
    required this.email,
    required this.date,
    required this.adPrice,
    required this.adStatus,
  });

  factory AdminSubmittedAdsListDataModel.fromMap(Map<String, dynamic> map,
      {String? adDocId}) {
    var adminAdsListDataModel = AdminSubmittedAdsListDataModel(
      submittedAdDocId: map['adDocId'] as String,
      adId: map['adId'] as String,
      taskName: map['userName'] as String,
      byCompany: map['company'] as String,
      email: map['email'] as String,
      date: map['date'] as DateTime,
      adPrice: map['adPrice'] as num,
      adStatus: map['adStatus'] as String,
    );
    return adminAdsListDataModel;
  }
}
