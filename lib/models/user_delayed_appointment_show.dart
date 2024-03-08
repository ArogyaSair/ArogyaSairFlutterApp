class UserDelayedAppointmentShow {
  final String id;
  final String appointmentId;
  final String appointmentDate;
  final String doctorName;
  final String oldDate;
  final String hospitalId;
  final String status;
  final String userId;

  UserDelayedAppointmentShow(
      this.id,
      this.appointmentId,
      this.doctorName,
      this.hospitalId,
      this.appointmentDate,
      this.oldDate,
      this.status,
      this.userId);

  factory UserDelayedAppointmentShow.fromMap(
      Map<dynamic, dynamic> map, String id) {
    return UserDelayedAppointmentShow(
      id,
      map["AppointmentId"] ?? '',
      map["DoctorName"] ?? '',
      map["HospitalId"] ?? '',
      map["NewDate"] ?? '',
      map["OldDate"] ?? '',
      map["Status"] ?? '',
      map["UserId"] ?? '',
    );
  }
}
