import 'package:sendbirdtutorial/data/data_sources/remote_data_source/users_data_source.dart';
import 'package:sendbirdtutorial/domain/entities/chat_user.dart';
import 'package:sendbirdtutorial/domain/repositories/users_repository.dart';
import 'package:sendbirdtutorial/data/data_sources/remote_data_source/models/user.dart';

class UsersRepositoryImpl implements UsersRepository {
  UsersDataSource usersDataSource;

  UsersRepositoryImpl({required this.usersDataSource});

  @override
  ChatUser getCurrentUser() {
    return usersDataSource.getCurrentUser()!.toDomain();
  }

  @override
  Future<List<ChatUser>> getUsers() async {
    var listUsers = await usersDataSource.getUsers();
    return listUsers.map((e) => e.toDomain()).toList();
  }
}
