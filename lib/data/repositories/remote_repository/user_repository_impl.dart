import 'package:sendbirdtutorial/locator/locator.dart';

import '../../data_sources/remote_data_source/sendbird_user_remote_data_source.dart';
import '../../../domain/entities/chat_user.dart';
import '../../../domain/repositories/user_repository.dart';

class AuthRespositoryImpl implements AuthRepository {
  final SendbirdUserRemoteDataSource _sendbirdUserRemoteDataSource =
      locator.get<SendbirdUserRemoteDataSource>();

  @override
  Future<ChatUser> connect(String userId, String nickname) async {
    try {
      var user = await _sendbirdUserRemoteDataSource.connect(userId, nickname);
      var chatUser = ChatUser(
        userId: user.userId,
        nickname: user.nickname,
        isActive: user.isActive,
        profileUrl: user.profileUrl,
        lastSeenAt: user.lastSeenAt,
      );
      return chatUser;
    } catch (e) {
      print('UserRepositoryImpl connect: $e');
      throw Exception(e);
    }
  }

  void disconnect() {
    _sendbirdUserRemoteDataSource.disconnect();
  }
}
