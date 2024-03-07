class UserUpdateShow {
  final String id;
  final String appointmentDate;
  final String disease;
  final String hospitalId;
  final String status;
  final String userId;

  UserUpdateShow(this.id, this.appointmentDate, this.disease, this.hospitalId,
      this.status, this.userId);

  factory UserUpdateShow.fromMap(Map<dynamic, dynamic> map, String id) {
    return UserUpdateShow(
      id,
      map["AppointmentDate"] ?? '', // Use an empty string if it's null
      map["Disease"],
      map["HospitalId"] ?? '', // Use an empty string if it's null
      map["Status"] ?? '', // Use an empty string if it's null
      map["UserId"] ?? '', // Use an empty string if it's null
    );
  }
}
