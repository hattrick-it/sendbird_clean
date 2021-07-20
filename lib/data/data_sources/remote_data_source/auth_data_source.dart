import 'package:sendbird_sdk/sendbird_sdk.dart';


class AuthRemoteDataSource {
  final SendbirdSdk sendbird;
AuthRemoteDataSource({this.sendbird});

  Future<User> connect(String userId, String nickname) async {
    try {
      var user = await sendbird.connect(userId);
      await sendbird.updateCurrentUserInfo(nickname: nickname);
      return user;
    } catch (e) {
      throw Exception(e);
    }
  }

  void disconnect() {
    sendbird.disconnect();
  }
}
