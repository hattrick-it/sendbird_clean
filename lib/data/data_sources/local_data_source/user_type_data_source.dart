
import 'package:sendbirdtutorial/Core/string_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserTypeDataSource {
  Future<void> saveUserType(String userType) async {
    if(userType == null) userType = 'admin';
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(StringConstants.userTypeKey, userType);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> getCurrentUserType() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userType =  prefs.getString(StringConstants.userTypeKey);
      print(userType);
      return userType;
    } catch (e) {
      throw Exception(e);
    }
  }
}
