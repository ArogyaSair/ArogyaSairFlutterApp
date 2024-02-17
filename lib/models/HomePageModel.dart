// ignore_for_file: file_names

class HomeData {
  final String id;
  final String hospitalEmail;
  final String? hospitalImage;
  final String hospitalName;

  HomeData(this.id, this.hospitalEmail, this.hospitalImage, this.hospitalName);

  // Add a factory constructor to create an instance from a Map
  factory HomeData.fromMap(Map<dynamic, dynamic> map, String id) {
    return HomeData(
      id,
      map["HospitalEmail"] ?? '', // Use an empty string if it's null
      map["Photo"],
      map["HospitalName"] ?? '', // Use an empty string if it's null
    );
  }
}
