import '../../../domain/entities/chat_user.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../data_sources/remote_data_source/auth_data_source.dart';
import '../../data_sources/remote_data_source/models/user.dart';

class AuthRespositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRespositoryImpl({this.authRemoteDataSource});

  @override
  Future<ChatUser> connect(String userId, String nickname) async {
    try {
      var user = await authRemoteDataSource.connect(userId, nickname);
      return user.toDomain();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> saveUserType(String userType) {
    authRemoteDataSource.saveUserType(userType);
  }

  void disconnect() {
    authRemoteDataSource.disconnect();
  }
}
