import 'package:sendbirdtutorial/locator/locator.dart';

import '../../data_sources/remote_data_source/sendbird_user_remote_data_source.dart';
import '../../../domain/entities/chat_user.dart';
import '../../../domain/repositories/user_repository.dart';
import 'package:sendbirdtutorial/data/data_sources/remote_data_source/models/sendbird_user.dart';

class AuthRespositoryImpl implements AuthRepository {
  final SendbirdUserRemoteDataSource sendbirdUserRemoteDataSource;
  AuthRespositoryImpl({this.sendbirdUserRemoteDataSource});

  @override
  Future<ChatUser> connect(String userId, String nickname) async {
    try {
      var user = await sendbirdUserRemoteDataSource.connect(userId, nickname);
      var chatUser = user.toDomain();
      return chatUser;
    } catch (e) {
      throw Exception(e);
    }
  }

  void disconnect() {
    sendbirdUserRemoteDataSource.disconnect();
  }
}
