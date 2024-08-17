import 'package:shared_preferences/shared_preferences.dart';
class SharedPref{
  static String? name;
  final _pref = SharedPreferences.getInstance();
  addStringToSF(key,val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, val);
  }

  viewString(key) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString(key);
    print("syahsahs$name");
  }
}