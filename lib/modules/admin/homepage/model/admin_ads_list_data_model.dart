class AdminAdsListDataModel {
  String? docId;
  String adName;
  String adContent;
  String? adStatus;
  DateTime addedDate;
  String byCompany;
  List<String>? imageUrl;
  num adPrice;

  AdminAdsListDataModel({
    this.docId,
    required this.adName,
    required this.adContent,
    this.adStatus,
    required this.addedDate,
    required this.byCompany,
    this.imageUrl,
    required this.adPrice,
  });

  factory AdminAdsListDataModel.fromMap(Map<String, dynamic> map,
      {String? docId}) {
    return AdminAdsListDataModel(
      docId: docId,
      adName: map['adName'] as String,
      adPrice: map['adPrice'] as num,
      adStatus: map['adStatus'] as String,
      addedDate: map['addedDate'] as DateTime,
      imageUrl: (map['adImageUrl'] as List<dynamic>?)?.cast<String>() ?? [],
      adContent: map['adContent'] as String,
      byCompany: map['byCompany'] as String,
    );
  }
}
