import 'package:shared_preferences/shared_preferences.dart';

String userUid;

class LocalService {
  Future<bool> saveNameId(String transId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("transId", transId);
    return prefs.commit();
  }

  Future<bool> saveUrlId(String transUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("transUrl", transUrl);
    return prefs.commit();
  }

  Future<String> getUrlId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String transUrl = prefs.getString("transUrl");
    return transUrl;
  }

  Future<String> getNameId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String transId = prefs.getString("transId");
    return transId;
  }
}
