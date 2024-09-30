import 'package:shared_preferences/shared_preferences.dart';

class SaveUser {
  

  // save user
  Future<void> saveUser(bool user) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("user", user);
  }

  // load user
  Future<bool> getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool("user") ?? false;
  }
 

}