import '../../../domain/entities/chat_user.dart';
import '../../../domain/repositories/user_selection_repository.dart';
import '../../data_sources/remote_data_source/users_data_source.dart';

class UserSelectionRepositoryImpl implements UserSelectionRepository {
  UsersDataSource usersDataSource;

  UserSelectionRepositoryImpl({
    this.usersDataSource,
  });

  // add to repo interface
  @override
  Future<List<ChatUser>> getUserByName(String name) async {
    return usersDataSource.getUserByName(name);
  }

  @override
  Future<List<ChatUser>> getUsersByType() async {
    return await usersDataSource.getUsersByType();
  }

  @override
  Future<List<ChatUser>> getDoctorBySpecialty(String specialty) async {
    return usersDataSource.getDoctorBySpecialty(specialty);
  }

  Future<Map<String, bool>> getSpecialtyMap() async {
    return usersDataSource.getSpecialtyMap();
  }
}
