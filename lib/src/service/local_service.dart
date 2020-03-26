import 'package:shared_preferences/shared_preferences.dart';

String userUid;
LocalService _localService = LocalService();
String _url;

@override
void initState() {
  _localService.getNameId().then(updateUrl);
}

class LocalService {
  Future<bool> saveNameId(String transId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("transId", transId);
    return prefs.commit();
  }

  Future<String> getNameId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String transId = prefs.getString("transId");
    return transId;
  }
}

void updateUrl(String transUrl) {
  _url = transUrl;
}
