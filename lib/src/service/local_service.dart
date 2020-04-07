import 'package:shared_preferences/shared_preferences.dart';

String userUid;
String walletId, userId, message;
bool isLogin;

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

  // LOGIN
  Future<bool> isLogin(bool isLogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLogin", isLogin);
    return prefs.commit();
  }

  Future<bool> saveWalletId(String walletId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("walletId", walletId);
    return prefs.commit();
  }

  Future<String> getWalletId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String walletId = prefs.getString("walletId");
    return walletId;
  }

  Future<bool> saveUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userId", userId);
    return prefs.commit();
  }

  // BPJS
  Future<bool> saveUrl(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("url", url);
    return prefs.commit();
  }

  Future<String> getUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = prefs.getString("url");
    return url;
  }
}