// ignore_for_file: file_names

class HomeData {
  final String id;
  final String hospitalEmail;
  final String? hospitalImage;
  final String hospitalName;
  final String hospitalAddress;
  final String hospitalCity;
  final String hospitalState;

  HomeData(this.id, this.hospitalEmail, this.hospitalImage, this.hospitalName,
      this.hospitalAddress, this.hospitalCity, this.hospitalState);

  // Add a factory constructor to create an instance from a Map
  factory HomeData.fromMap(Map<dynamic, dynamic> map, String id) {
    return HomeData(
      id,
      map["Email"] ?? '', // Use an empty string if it's null
      map["Photo"],
      map["HospitalName"] ?? '', // Use an empty string if it's null
      map["HospitalAddress"] ?? '',
      // Use an empty string if it's null
      map["HospitalCity"] ?? '',
      // Use an empty string if it's null
      map["HospitalState"] ?? '', // Use an empty string if it's null
    );
  }
}
