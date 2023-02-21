class UserData {
  int? id;
  String? uid;
  String? password;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? avatar;
  String? gender;
  String? phoneNumber;
  String? socialInsuranceNumber;

  UserData({
    this.id,
    this.uid,
    this.password,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.avatar,
    this.gender,
    this.phoneNumber,
    this.socialInsuranceNumber,
  });

  UserData.fromMap(Map<String, dynamic> result)
      : id = result["id"],
        uid = result["uid"],
        password = result["password"],
        firstName = result["first_name"],
        lastName = result["last_name"],
        username = result["username"],
        email = result["email"],
        avatar = result["avatar"],
        gender = result["gender"],
        phoneNumber = result["phone_number"],
        socialInsuranceNumber = result["social_insurance_number"];
  Map<String, Object> toMap() {
    return {
      "id": id!,
      "uid": uid!,
      "password": password!,
      "first_name": firstName!,
      "last_name": lastName!,
      "username": username!,
      "email": email!,
      "avatar": avatar!,
      "gender": gender!,
      "phone_number": phoneNumber!,
      "social_insurance_number": socialInsuranceNumber!,
    };
  }
}
