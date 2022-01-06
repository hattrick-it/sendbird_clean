import 'dart:async';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbirdtutorial/Core/constants.dart';
import 'package:sendbirdtutorial/data/data_sources/remote_data_source/user_batch_data_entry.dart';
import 'package:sendbird_sdk/query/user_list/user_list_query.dart' as sendQuery;
import '../../../domain/entities/chat_user.dart';
import '../local_data_source/user_type_data_source.dart';
import 'models/user.dart';

class UsersDataSource {
  final SendbirdSdk sendbird;
  final UserTypeDataSource localUserTypeDataSource;

  UsersDataSource({
    required this.sendbird,
    required this.localUserTypeDataSource,
  });

  Future<List<User>> getUsers() async {
    await sendbird.connect(Constants.adminUserId,
        nickname: Constants.adminNickName);
    final query = sendQuery.ApplicationUserListQuery();
    try {
      var list = await query.loadNext();
      if (list.length <= 2) await createUsers();
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> createUsers() async {
    try {
      var batch = UserBatchDataEntry(sendbird: sendbird);
      await batch.createDoctors();
      await batch.createPatients();
      return true;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  User? getCurrentUser() {
    try {
      return sendbird.currentUser;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String?> getCurrentType() async {
    var current = await localUserTypeDataSource.getCurrentUserType();
    return current;
  }

// getUserByName(String name)
  Future<List<ChatUser>?> getUserByName(String name) async {
    try {
      var list = await getUsersByType();
      return list!
          .where((element) =>
              element.nickname!.toLowerCase().contains(name.toLowerCase()))
          .toList();
    } catch (e) {
      Exception(e);
    }
  }

  // getUsersByType()
  Future<List<ChatUser>?> getUsersByType() async {
    try {
      final usertype = await getTypeByUserLogged();
      final listQuery = ApplicationUserListQuery();
      var userList = await listQuery.loadNext();
      var returnList =
          userList.where((element) => element.metaData['userType'] == usertype);
      return returnList.map((e) => e.toDomain()).toList();
    } catch (e) {
      Exception(e);
    }
  }

  Future<String> getTypeByUserLogged() async {
    final currentType = await getCurrentType();
    if (currentType == 'Patient') {
      return 'Doctor';
    } else {
      return 'Patient';
    }
  }

  Future<List<ChatUser>?> getDoctorBySpecialty(String specialty) async {
    try {
      final userList = await ApplicationUserListQuery().loadNext();
      if (specialty == 'All') {
        return getUsersByType();
      }
      return userList
          .where((element) => element.metaData['Specialty'] == specialty)
          .map((e) => e.toDomain())
          .toList();
    } catch (e) {
      Exception(e);
    }
  }

  Future<Map<String, bool>> getSpecialtyMap() async {
    Map<String, bool> returnMap = {'All': true};
    try {
      final userList = await ApplicationUserListQuery().loadNext();
      userList
          .where((element) => element.metaData.containsKey('Specialty'))
          .map((e) => e.metaData['Specialty'])
          .toSet()
          .toList()
          .forEach((element) {
        returnMap[element!] = false;
      });
      return returnMap;
    } catch (e) {
      throw Exception(e);
    }
  }
}
