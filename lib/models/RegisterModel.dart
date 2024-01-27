class RegisterModel{
  late String username;
  late String password;
  late String name;
  late String email;
  late String DOB;
  RegisterModel(this.username, this.password, this.email, this.name, this.DOB);
  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'Username': username,
    'Password': password,
    'Name': name,
    'Email': email,
    'DOB' : DOB,
  };
  factory RegisterModel.fromJson(Map<String, dynamic> v) {
    return RegisterModel(
        v["username"], v["name"],v["password"], v["email"], v["DOB"]
    );
  }
}