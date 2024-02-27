// ignore_for_file: file_names

class TreatmentModel {
  final String id;
  final String treatment;

  TreatmentModel(this.id, this.treatment);

  factory TreatmentModel.fromMap(Map<dynamic, dynamic> map, String id) {
    return TreatmentModel(
      id,
      map["TreatmentName"] ?? '',
    );
  }

  @override
  String toString() {
    return 'Treatment: $treatment';
  }
}
