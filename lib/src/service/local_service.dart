import 'package:shared_preferences/shared_preferences.dart';

String userUid;
String walletId, userId, message;
bool isLogin;

class LocalService {
  Future<bool> saveIdName(String transIdName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("transIdName", transIdName);
    return prefs.commit();
  }

    Future<bool> saveNameProv(String transNameProv) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("transNameProv", transNameProv);
    return prefs.commit();
  }

  Future<bool> saveUrlName(String transUrlName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("transUrlName", transUrlName);
    return prefs.commit();
  }

  Future<String> getUrlName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String transUrlName = prefs.getString("transUrlName");
    return transUrlName;
  }

  Future<String> getIdName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String transIdName = prefs.getString("transIdName");
    return transIdName;
  }

  Future<String> getNamaProv() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String transProvider = prefs.getString("transProvider");
    return transProvider;
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