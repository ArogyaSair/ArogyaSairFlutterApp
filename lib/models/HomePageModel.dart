// ignore_for_file: file_names

class HomeData {
  final String id;
  final String hospitalEmail;
  final String? hospitalImage;
  final String hospitalName;
  final String hospitalAddress;
  final String hospitalCity;
  final String hospitalState;
  final String hospitalFCMToken;

  HomeData(this.id, this.hospitalEmail, this.hospitalImage, this.hospitalName,
      this.hospitalAddress,
      this.hospitalCity,
      this.hospitalState,
      this.hospitalFCMToken);

  factory HomeData.fromMap(Map<dynamic, dynamic> map, String id) {
    return HomeData(
      id,
      map["Email"] ?? '',
      map["Photo"],
      map["HospitalName"] ?? '',
      map["HospitalAddress"] ?? '',
      map["HospitalCity"] ?? '',
      map["HospitalState"] ?? '',
      map["HospitalFCMToken"] ?? '',
    );
  }
}
