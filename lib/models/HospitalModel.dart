// ignore_for_file: file_names

class HospitalData {
  final String id;
  final String hospitalName;

  HospitalData(this.id, this.hospitalName);

  // Add a factory constructor to create an instance from a Map
  factory HospitalData.fromMap(Map<dynamic, dynamic> map, String id) {
    return HospitalData(
      id,
      map["HospitalName"] ?? '', // Use an empty string if it's null
    );
  }

  @override
  String toString() {
    return id;
  }
}
