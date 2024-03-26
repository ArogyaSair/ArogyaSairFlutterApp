// ignore_for_file: file_names

class AppointmentData {
  final String id;
  final String appointmentDate;
  final String? disease;
  final String hospitalId;
  final String status;
  final String userID;

  AppointmentData(this.id, this.appointmentDate, this.disease, this.hospitalId,
      this.status, this.userID);

  // Add a factory constructor to create an instance from a Map
  factory AppointmentData.fromMap(Map<dynamic, dynamic> map, String id) {
    return AppointmentData(
      id,
      map["AppointmentDate"] ?? '', // Use an empty string if it's null
      map["Disease"],
      map["HospitalId"] ?? '', // Use an empty string if it's null
      map["Status"] ?? '',
      map["UserID"] ?? '', // Use an empty string if it's null
    );
  }
}
