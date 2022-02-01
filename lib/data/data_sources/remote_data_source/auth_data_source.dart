import 'package:sendbird_sdk/sendbird_sdk.dart';
import '../local_data_source/user_type_data_source.dart';

class AuthRemoteDataSource {
  final SendbirdSdk sendbird;
  final UserTypeDataSource userTypeDataSource;

  AuthRemoteDataSource(
      {required this.sendbird, required this.userTypeDataSource});

  Future<User> connect(String userId, String nickname) async {
    try {
      var user = await sendbird.connect(userId, nickname: nickname);
      return user;
    } catch (e) {
      throw Exception(e);
    }
  }

  void disconnect() {
    sendbird.disconnect();
  }

  void saveUserType(String userType) async {
    await userTypeDataSource.saveUserType(userType);
  }
}
