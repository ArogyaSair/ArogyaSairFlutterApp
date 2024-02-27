// ignore_for_file: file_names, non_constant_identifier_names

class PackageData {
  final String id;
  final String packagename;
  final String price;
  final String hospitalname;
  final String Duration;
  final String include;

  PackageData(this.id, this.packagename, this.price, this.hospitalname,
      this.Duration, this.include);

  factory PackageData.fromMap(Map<dynamic, dynamic> map, String id) {
    return PackageData(
      id,
      map["PackageName"] ?? '',
      map["Price"] ?? '',
      map["HospitalName"] ?? '',
      map["Include"] ?? '',
      map["Duration"] ?? '',
    );
  }
}
