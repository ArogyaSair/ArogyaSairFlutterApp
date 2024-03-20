// ignore_for_file: file_names

class SurgeryModel {
  final String id;
  final String surgery;

  SurgeryModel(this.id, this.surgery);

  factory SurgeryModel.fromMap(Map<dynamic, dynamic> map, String id) {
    return SurgeryModel(
      id,
      map["SurgeryName"] ?? '',
    );
  }

  @override
  String toString() {
    return surgery;
  }
}
