// ignore_for_file: file_names, non_constant_identifier_names

class UserPackageData {
  final String id;
  final String image;
  final String packagename;
  final String price;
  final String hospitalname;
  final String Duration;
  final String include;

  UserPackageData(this.id, this.image, this.packagename, this.price,
      this.hospitalname, this.Duration, this.include);

  factory UserPackageData.fromMap(Map<dynamic, dynamic> map, String id) {
    return UserPackageData(
      id,
      map["Photo"] ?? '',
      map["PackageName"] ?? '',
      map["Price"] ?? '',
      map["HospitalName"] ?? '',
      map["Duration"] ?? '',
      map["Include"] ?? '',
    );
  }
}
