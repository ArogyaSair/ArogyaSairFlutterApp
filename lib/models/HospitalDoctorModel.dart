// ignore_for_file: file_names

class HospitalDoctorData {
  final String id;
  final String? doctorImage;
  final String doctorName;

  // final String doctorName;

  HospitalDoctorData(this.id, this.doctorName, this.doctorImage);

  // Add a factory constructor to create an instance from a Map
  factory HospitalDoctorData.fromMap(Map<dynamic, dynamic> map, String id) {
    return HospitalDoctorData(
      id,
      // map["ServiceName"] ?? '', // Use an empty string if it's null
      map["DoctorName"] ?? '', // Use an empty string if it's null
      map["Photo"],
    );
  }
}
