// ignore_for_file: file_names

class DoctorData {
  final String id;
  final String facilities;

  DoctorData(this.id, this.facilities);

  factory DoctorData.fromMap(Map<dynamic, dynamic> map, String id) {
    return DoctorData(
      id,
      map["DoctorName"] ?? '',
    );
  }
}
