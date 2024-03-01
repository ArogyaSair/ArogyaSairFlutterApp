// ignore_for_file: file_names

class DoctorData {
  final String id;
  final String doctors;

  DoctorData(this.id, this.doctors);

  factory DoctorData.fromMap(Map<dynamic, dynamic> map, String id) {
    return DoctorData(
      id,
      map["DoctorName"]!.toString(),
    );
  }

  @override
  String toString() {
    return 'Doctors: $doctors';
  }
}
