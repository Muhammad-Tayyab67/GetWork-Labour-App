// ignore_for_file: file_names

class UserModel {
  String? lid;
  String? email;
  String? firstName;
  String? lastName;
  String? password;
  String? cityName;
  String? cnic;
  String? mobileNo;
  String? imagePath;

  UserModel(
      {this.lid,
      this.email,
      this.firstName,
      this.lastName,
      this.cnic,
      this.cityName,
      this.mobileNo,
      this.password,
      this.imagePath});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        lid: map['uid'],
        email: map['email'],
        firstName: map['firstName'],
        lastName: map['lastName'],
        cnic: map['cnic'],
        cityName: map['cityName'],
        mobileNo: map['mobileNo'],
        password: map['password'],
        imagePath: map['imagePath']);
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': lid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'cnic': cnic,
      'mobileNo': mobileNo,
      'cityName': cityName,
      'password': password,
      'imagePath': imagePath,
    };
  }
}
