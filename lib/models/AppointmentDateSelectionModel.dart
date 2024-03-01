// ignore_for_file: non_constant_identifier_names, file_names

class AppointmentDateSelectionModel {
  late String HospitalId;
  late String Disease;
  late String DOB;
  late String User;
  late String Status;

  AppointmentDateSelectionModel(
      this.HospitalId, this.Disease, this.DOB, this.User, this.Status);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'HospitalId': HospitalId,
        'Disease': Disease,
        'AppointmentDate': DOB,
        'UserId': User,
        'Status': Status,
      };

  factory AppointmentDateSelectionModel.fromJson(Map<String, dynamic> v) {
    return AppointmentDateSelectionModel(
        v["HospitalId"], v["Disease"], v["Date"], v["User"], v["Status"]);
  }
}
