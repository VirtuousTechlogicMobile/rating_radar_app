/// profileImg : "https://example.com/images/profile.jpg"
/// username : "john_doe"
/// email : "john.doe@example.com"
/// managerName : "Alice Smith"
/// companyName : "Tech Solutions Inc."
/// phoneNumber : "+1234567890"
/// city : "San Francisco"
/// state : "California"
/// panNumber : "ABCDE1234F"
/// CompanyGSTNumber : "22AAAAA0000A1Z5"
/// AadharNumber : "123456789012"
/// password : "SecurePassword123!"
/// managerId : "MGR123456"
/// aadharImage : "https://example.com/images/aadhar.jpg"
/// panImage : "https://example.com/images/pan.jpg"
/// GSTImage : "https://example.com/images/gst.jpg"

class ManagerModel {
  ManagerModel({
    required this.profileImg,
    required this.username,
    required this.email,
    required this.managerName,
    required this.companyName,
    required this.phoneNumber,
    required this.city,
    required this.state,
    required this.panNumber,
    required this.companyGSTNumber,
    required this.aadharNumber,
    required this.password,
    required this.managerId,
    required this.aadharImage,
    required this.panImage,
    required this.gstImage,
  });

  String profileImg;
  String username;
  String email;
  String managerName;
  String companyName;
  String phoneNumber;
  String city;
  String state;
  String panNumber;
  String companyGSTNumber;
  String aadharNumber;
  String password;
  String managerId;
  String aadharImage;
  String panImage;
  String gstImage;

  // Factory method to create a ManagerModel from a Map (JSON)
  factory ManagerModel.fromMap(Map<String, dynamic> map) {
    return ManagerModel(
      profileImg: map['profileImg'] ?? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      managerName: map['managerName'] ?? '',
      companyName: map['companyName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      panNumber: map['panNumber'] ?? '',
      companyGSTNumber: map['CompanyGSTNumber'] ?? '',
      aadharNumber: map['AadharNumber'] ?? '',
      password: map['password'] ?? '',
      managerId: map['managerId'] ?? '',
      aadharImage: map['aadharImage'] ?? '',
      panImage: map['panImage'] ?? '',
      gstImage: map['GSTImage'] ?? '',
    );
  }

  // Method to convert a ManagerModel into a Map (JSON)
  Map<String, dynamic> toMap() {
    return {
      'profileImg': profileImg,
      'username': username,
      'email': email,
      'managerName': managerName,
      'companyName': companyName,
      'phoneNumber': phoneNumber,
      'city': city,
      'state': state,
      'panNumber': panNumber,
      'CompanyGSTNumber': companyGSTNumber,
      'AadharNumber': aadharNumber,
      'password': password,
      'managerId': managerId,
      'aadharImage': aadharImage,
      'panImage': panImage,
      'GSTImage': gstImage,
    };
  }
}
