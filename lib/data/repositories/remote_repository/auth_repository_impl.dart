import '../../data_sources/remote_data_source/auth_data_source.dart';
import '../../../domain/repositories/auth_repository.dart';

class AuthRespositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRespositoryImpl({this.authRemoteDataSource});

  @override
  Future<void> connect(String userId, String nickname) async {
    try {
      await authRemoteDataSource.connect(userId, nickname);
    } catch (e) {
      throw Exception(e);
    }
  }

  void saveUserType(String userType){
    authRemoteDataSource.saveUserType(userType);
  }

  void disconnect() {
    authRemoteDataSource.disconnect();
  }
}
