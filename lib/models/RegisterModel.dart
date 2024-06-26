// ignore_for_file: non_constant_identifier_names, file_names

class RegisterModel {
  late String username;
  late String password;
  late String name;
  late String Lastname;
  late String email;
  late String DOB;
  late String contact;
  late String gender;
  late String bloodGroup;

  RegisterModel(this.username, this.password, this.email, this.name,
      this.Lastname, this.DOB, this.contact, this.gender, this.bloodGroup);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'Username': username,
        'Password': password,
        'FirstName': name,
        'LastName': Lastname,
        'Email': email,
        'DOB': DOB,
        'ContactNumber': contact,
        'Gender': gender,
        'BloodGroup': bloodGroup,
      };
}
