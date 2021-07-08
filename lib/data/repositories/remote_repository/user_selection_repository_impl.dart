import 'package:sendbirdtutorial/Core/string_constants.dart';

import '../../data_sources/remote_data_source/user_batch_data_entry.dart';
import '../../../domain/entities/chat_user.dart';
import '../../../domain/repositories/user_selection_repository.dart';
import '../../data_sources/remote_data_source/models/user.dart';

class UserSelectionRepositoryImpl implements UserSelectionRepository {
  SendbirdUserSelectionDataSource sendbirdUserSelectionDataSource;
  UserSelectionRepositoryImpl({this.sendbirdUserSelectionDataSource});

  @override
  Future<List<ChatUser>> getUsersByType(String userType) async {
    var users = await sendbirdUserSelectionDataSource.getUsers();
    return users
        .where((element) =>
            element.metaData.containsKey(StringConstants.userTypeKey) &&
            element.metaData[StringConstants.userTypeKey] == userType)
        .map((e) => e.toDomain())
        .toList();
  }
}
