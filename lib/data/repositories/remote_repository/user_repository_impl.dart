import '../../../domain/entities/chat_user.dart';
import '../../../domain/repositories/users_repository.dart';
import '../../data_sources/remote_data_source/models/user.dart';
import '../../data_sources/remote_data_source/users_data_source.dart';

class UsersRepositoryImpl implements UsersRepository {
  UsersDataSource usersDataSource;

  UsersRepositoryImpl({this.usersDataSource});

  @override
  ChatUser getCurrentUser() {
    return usersDataSource.getCurrentUser().toDomain();
  }

  @override
  Future<List<ChatUser>> getUsers() async {
    var listUsers = await usersDataSource.getUsers();
    return listUsers.map((e) => e.toDomain()).toList();
  }
}
