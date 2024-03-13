// ignore_for_file: file_names

class DiseaseData {
  final String id;
  final String diseaseName;

  DiseaseData(this.id, this.diseaseName);

  // Add a factory constructor to create an instance from a Map
  factory DiseaseData.fromMap(Map<dynamic, dynamic> map, String id) {
    return DiseaseData(
      id,
      map["DiseaseName"] ?? '', // Use an empty string if it's null
    );
  }
}
