import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  // checking authToken
  static Future<int> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int token = prefs.getInt("token") as int;
    return token;
  }

// set AuthToken once user login completed
  static Future<bool> setToken(int token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("token", token);
    return true;
  }

  // checking user email
  static Future<String> getUserEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("email") as String;
    return email;
  }

  static Future<bool> setUserEmail(String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", email);
    return true;
  }
}
