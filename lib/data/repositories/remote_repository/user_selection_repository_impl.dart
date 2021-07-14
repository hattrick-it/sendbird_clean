import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbirdtutorial/Core/string_constants.dart';
import 'package:sendbirdtutorial/data/data_sources/remote_data_source/users_data_source.dart';

import '../../data_sources/remote_data_source/user_batch_data_entry.dart';
import '../../../domain/entities/chat_user.dart';
import '../../../domain/repositories/user_selection_repository.dart';
import '../../data_sources/remote_data_source/models/user.dart';

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
    List<ChatUser> lista = await usersDataSource.getUsersByType();
    return lista;
  }

  @override
  Future<List<ChatUser>> getDoctorBySpecialty(String specialty) async {
    return usersDataSource.getDoctorBySpecialty(specialty);
  }
}
