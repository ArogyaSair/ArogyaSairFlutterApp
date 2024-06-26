// ignore_for_file: file_names

class HospitalAppointmentDelayedModel {
  late String appointmentId;
  late String newDate;
  late String doctorName;
  late String hospitalId;
  late String oldDate;
  late String userId;
  late String status;
  late String visitingTime;

  HospitalAppointmentDelayedModel(
      this.appointmentId,
      this.newDate,
      this.doctorName,
      this.hospitalId,
      this.oldDate,
      this.userId,
      this.status,
      this.visitingTime);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'AppointmentId': appointmentId,
        'NewDate': newDate,
        'DoctorName': doctorName,
        'HospitalId': hospitalId,
        'OldDate': oldDate,
        'UserId': userId,
        'Status': status,
        'VisitingTime': visitingTime,
      };

  factory HospitalAppointmentDelayedModel.fromJson(Map<String, dynamic> v) {
    return HospitalAppointmentDelayedModel(
      v['AppointmentId'],
      v['NewDate'],
      v['DoctorName'],
      v['HospitalId'],
      v['OldDate'],
      v['UserId'],
      v["Status"],
      v["VisitingTime"],
    );
  }
}
