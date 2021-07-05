import 'package:shared_preferences/shared_preferences.dart';

class LocalUserTypeDataSource {
  Future<void> saveUserType(String userType) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userType', userType);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> getCurrentUserType() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('userType');
    } catch (e) {
      throw Exception(e);
    }
  }
}
