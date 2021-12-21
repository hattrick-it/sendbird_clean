import 'package:sendbird_sdk/sendbird_sdk.dart';

class UsersDataSource {
  final SendbirdSdk sendbird;
  UsersDataSource({required this.sendbird});

  Future<List<User>> getUsers() {
    try {
      final query = ApplicationUserListQuery();
      return query.loadNext();
    } catch (e) {
      throw Exception(e);
    }
  }

  User? getCurrentUser() {
    try {
      return sendbird.currentUser;
    } catch (e) {
      throw Exception(e);
    }
  }
}
