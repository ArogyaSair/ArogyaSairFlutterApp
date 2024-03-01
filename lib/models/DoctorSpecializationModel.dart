// ignore_for_file: file_names

class DoctorSpecializationModel {
  final String id;
  final String specialization;

  DoctorSpecializationModel(this.id, this.specialization);

  factory DoctorSpecializationModel.fromMap(
      Map<dynamic, dynamic> map, String id) {
    return DoctorSpecializationModel(
      id,
      map["Specilization"] ?? '',
    );
  }

  @override
  String toString() {
    return 'Specialization: $specialization';
  }
}
