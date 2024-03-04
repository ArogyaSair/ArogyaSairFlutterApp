// ignore_for_file: file_names

class HospitalAppointmentDelayedModel {
  late String appointmentId;
  late String newDate;
  late String doctorName;
  late String hospitalId;

  HospitalAppointmentDelayedModel(
      this.appointmentId, this.newDate, this.doctorName, this.hospitalId);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'AppointmentId': appointmentId,
        'NewDate': newDate,
        'DoctorName': doctorName,
        'HospitalId': hospitalId
      };

  factory HospitalAppointmentDelayedModel.fromJson(Map<String, dynamic> v) {
    return HospitalAppointmentDelayedModel(
      v['AppointmentId'],
      v['NewDate'],
      v['DoctorName'],
      v['HospitalId'],
    );
  }
}
