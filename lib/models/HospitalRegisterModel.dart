// ignore_for_file: non_constant_identifier_names, file_names

class HospitalRegisterModel {
  late String password;
  late String name;
  late String email;

  HospitalRegisterModel(this.password, this.email, this.name);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'Password': password,
        'HospitalName': name,
        'Email': email,
      };

  factory HospitalRegisterModel.fromJson(Map<String, dynamic> v) {
    return HospitalRegisterModel(v["password"], v["email"], v["name"]);
  }
}
