import 'package:shared_preferences/shared_preferences.dart';

import '../../../Core/string_constants.dart';

class UserTypeDataSource {
  Future<void> saveUserType(String userType) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(StringConstants.userTypeKey, userType);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String?> getCurrentUserType() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userType = prefs.getString(StringConstants.userTypeKey);
      return userType;
    } catch (e) {
      throw Exception(e);
    }
  }
}
