
import '../../data_sources/remote_data_source/auth_data_source.dart';
import '../../../domain/entities/chat_user.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'package:sendbirdtutorial/data/data_sources/remote_data_source/models/user.dart';

class AuthRespositoryImpl implements AuthRepository {
  final AuthRemoteDataSource sendbirdUserRemoteDataSource;
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
