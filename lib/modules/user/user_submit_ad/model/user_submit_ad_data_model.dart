class UserSubmitAdDataModel {
  String? currentDocId;
  String adId;
  String uId;
  List<String>? imageList;
  DateTime addedDate;
  String comments;
  String status;

  UserSubmitAdDataModel({
    this.currentDocId,
    required this.adId,
    required this.uId,
    this.imageList,
    required this.addedDate,
    required this.comments,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'adId': adId,
      'uId': uId,
      'imageList': imageList,
      'addedDate': addedDate,
      'comments': comments,
      'status': status,
    };
  }
}
