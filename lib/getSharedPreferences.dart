import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? value = prefs.getString('username');
  return value;
}
