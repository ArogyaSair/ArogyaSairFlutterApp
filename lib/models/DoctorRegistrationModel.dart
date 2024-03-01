// ignore_for_file: non_constant_identifier_names, file_names

class DoctorRegisterModel {
  late String password;
  late String name;
  late String email;
  late String DOB;
  late String gender;
  late String contact;
  late String address;
  late String photo;
  late String Specilization;

  DoctorRegisterModel(this.password, this.email, this.name, this.DOB,
      this.gender, this.contact, this.address, this.photo, this.Specilization);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'Password': password,
        'DoctorName': name,
        'Email': email,
        'DateOfBirth': DOB,
        'Contact': contact,
        'Gender': gender,
        'DoctorAddress': address,
        'Photo': photo,
        'Speciality': Specilization,
      };

  factory DoctorRegisterModel.fromJson(Map<String, dynamic> v) {
    return DoctorRegisterModel(
        v["name"],
        v["password"],
        v["email"],
        v["DOB"],
        v["Gender"],
        v["Contact"],
        v["Address"],
        v["Photo"],
        v["Specilization"]);
  }
}
