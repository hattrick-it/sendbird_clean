import 'package:sendbird_sdk/sendbird_sdk.dart';

import '../../../main.dart';

class SendbirdUserRemoteDataSource {
  final SendbirdSdk sendbird;
SendbirdUserRemoteDataSource({this.sendbird});

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
