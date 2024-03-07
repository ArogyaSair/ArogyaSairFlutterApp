// ignore_for_file: non_constant_identifier_names, file_names

class RegisterModel{
  late String username;
  late String password;
  late String name;
  late String email;
  late String DOB;
  late String contact;

  RegisterModel(this.username, this.password, this.email, this.name, this.DOB,
      this.contact);
  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'Username': username,
    'Password': password,
    'Name': name,
    'Email': email,
    'DOB' : DOB,
        'ContactNumber': contact,
      };
  factory RegisterModel.fromJson(Map<String, dynamic> v) {
    return RegisterModel(v["username"], v["name"], v["password"], v["email"],
        v["DOB"], v["ContactNumber"]);
  }
}