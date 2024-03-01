// ignore_for_file: non_constant_identifier_names, file_names, prefer_typing_uninitialized_variables

class HospitalDoctor {
  late var doctor;
  late String hospital_ID;
  late String status;
  late String timeFrom;
  late String timeTo;

  HospitalDoctor(
      this.doctor, this.hospital_ID, this.status, this.timeFrom, this.timeTo);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'Doctor': doctor,
        'Hospital_ID': hospital_ID,
        'Doctor_Status': status,
        'TimeFrom': timeFrom,
        'TimeTo': timeTo,
      };

  factory HospitalDoctor.fromJson(Map<String, dynamic> v) {
    return HospitalDoctor(v["Doctor"], v["Hospital_ID"], v["Doctor_Status"],
        v["TimeFrom"], v["TimeTo"]);
  }

  factory HospitalDoctor.fromMap(Map<dynamic, dynamic> map, String id) {
    return HospitalDoctor(
      // id,
      map["Doctor"] ?? '',
      map["Hospital_ID"] ?? '',
      map["Doctor_Status"] ?? '',
      map["TimeFrom"] ?? '',
      map["TimeTo"] ?? '',
    );
  }

  @override
  String toString() {
    return 'Doctor: $doctor';
  }
}
