// ignore_for_file: non_constant_identifier_names, file_names

class Packagemodel {
  late String packagename;
  late String price;
  late String hospitalname;
  late String Duration;
  late String include;

  Packagemodel(this.packagename, this.price, this.hospitalname, this.include,
      this.Duration);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'PackageName': packagename,
        'Price': price,
        'HospitalName': hospitalname,
        'Include': include,
        'Duration': Duration,
      };

  factory Packagemodel.fromJson(Map<String, dynamic> v) {
    return Packagemodel(v["PackageName"], v["Price"], v["HospitalName"],
        v["Include"], v["Duration"]);
  }
}
