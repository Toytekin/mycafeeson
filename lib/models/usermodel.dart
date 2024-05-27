class UserModel {
  String userID;
  String userName;
  String userMail;
  String userSifre;

  UserModel({
    required this.userID,
    required this.userName,
    required this.userMail,
    required this.userSifre,
  });

  // UserModel'i Map'e dönüştüren metot
  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'userName': userName,
      'userMail': userMail,
      'userSifre': userSifre,
    };
  }

  // Map'i UserModel'e dönüştüren metot
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userID: map['userID'] ?? '',
      userName: map['userName'] ?? '',
      userMail: map['userMail'] ?? '',
      userSifre: map['userSifre'] ?? '',
    );
  }
}
