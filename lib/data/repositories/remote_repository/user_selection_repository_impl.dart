import 'package:sendbirdtutorial/data/data_sources/remote_data_source/sendbird_user_selection_data_source.dart';
import 'package:sendbirdtutorial/domain/entities/chat_user.dart';
import 'package:sendbirdtutorial/domain/repositories/user_selection_repository.dart';
import 'package:sendbirdtutorial/locator/locator.dart';
import 'package:sendbirdtutorial/data/data_sources/remote_data_source/models/sendbird_user.dart';

class UserSelectionRepositoryImpl implements UserSelectionRepository {
  SendbirdUserSelectionDataSource sendbirdUserSelectionDataSource;
  UserSelectionRepositoryImpl({this.sendbirdUserSelectionDataSource});

  @override
  Future<List<ChatUser>> getUsersByType(String userType) async {
    var users = await sendbirdUserSelectionDataSource.getUsers();
    return users
        .where((element) =>
            element.metaData.containsKey('userType') &&
            element.metaData['userType'] == userType)
        .map((e) => e.toDomain())
        .toList();
  }
}
