// ignore_for_file: file_names

class FacilityData {
  final String id;
  final String facilities;

  FacilityData(this.id, this.facilities);

  factory FacilityData.fromMap(Map<dynamic, dynamic> map, String id) {
    return FacilityData(
      id,
      map["ServiceName"] ?? '',
    );
  }

  @override
  String toString() {
    return 'Facilities: $facilities';
  }
}
