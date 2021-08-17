import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbirdtutorial/data/data_sources/local_data_source/user_type_data_source.dart';

class AuthRemoteDataSource {
  final SendbirdSdk sendbird;
  final UserTypeDataSource userTypeDataSource;

  AuthRemoteDataSource({this.sendbird, this.userTypeDataSource});

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
