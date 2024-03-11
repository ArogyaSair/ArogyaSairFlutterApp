// ignore_for_file: non_constant_identifier_names, file_names

class BookingPackagesInformationModel {
  late String packagename;
  late String price;
  late String hospitalname;
  late String duration;
  late String include;
  late String date;
  late String username;

  BookingPackagesInformationModel(this.packagename, this.price,
      this.hospitalname, this.duration, this.include, this.date, this.username);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'PackageName': packagename,
        'Price': price,
        'HospitalName': hospitalname,
        'Include': include,
        'Duration': duration,
        'Date_of_starting': date,
        'UserName': username,
      };

  factory BookingPackagesInformationModel.fromJson(Map<String, dynamic> v) {
    return BookingPackagesInformationModel(
        v["PackageName"],
        v["Price"],
        v["HospitalName"],
        v["Duration"],
        v["Include"],
        v["Date_of_starting"],
        v["UserName"]);
  }
}
