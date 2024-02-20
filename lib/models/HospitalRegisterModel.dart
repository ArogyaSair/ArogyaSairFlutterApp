// ignore_for_file: non_constant_identifier_names, file_names

class HospitalRegisterModel {
  late String password;
  late String name;
  late String email;
  late String doctors;
  late String facilities;
  late String treatments;
  late String address;
  late String city;
  late String state;
  late String photo;

  HospitalRegisterModel(
      this.password,
      this.name,
      this.email,
      this.doctors,
      this.facilities,
      this.treatments,
      this.address,
      this.city,
      this.state,
      this.photo);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'Password': password,
        'HospitalName': name,
        'Email': email,
        'AvailableDoctors': doctors,
        'AvailableFacilities': facilities,
        'AvailableTreatments': treatments,
        'HospitalAddress': address,
        'HospitalCity': city,
        'HospitalState': state,
        'Photo': photo,
      };

  factory HospitalRegisterModel.fromJson(Map<String, dynamic> v) {
    return HospitalRegisterModel(
        v["password"],
        v["email"],
        v["name"],
        v["doctors"],
        v["facilities"],
        v["treatments"],
        v["address"],
        v["city"],
        v["state"],
        v["photo"]);
  }
}
