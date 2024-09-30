import 'package:shared_preferences/shared_preferences.dart';

class InvoiceId {
  

  // save user
  Future<void> saveId(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("id", id);
  }

  // load user
  Future<int> getId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt("id") ?? 100;
  }
 

}