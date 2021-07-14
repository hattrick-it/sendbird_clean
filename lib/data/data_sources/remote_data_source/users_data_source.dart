import 'dart:async';

import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbirdtutorial/data/data_sources/local_data_source/user_type_data_source.dart';
import 'package:sendbirdtutorial/domain/entities/chat_user.dart';
import 'package:sendbirdtutorial/data/data_sources/remote_data_source/models/user.dart';

class UsersDataSource {
  final SendbirdSdk sendbird;
  final UserTypeDataSource localUserTypeDataSource;

  UsersDataSource({
    this.sendbird,
    this.localUserTypeDataSource,
  });

  Future<List<User>> getUsers() async {
    try {
      final query = ApplicationUserListQuery();
      final list = await query.loadNext();
      print('asdas');
    } catch (e) {
      throw Exception(e);
    }
  }

  User getCurrentUser() {
    try {
      return sendbird.currentUser;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> getCurrentType() async {
    return await localUserTypeDataSource.getCurrentUserType();
  }

// getUserByName(String name)
  Future<List<ChatUser>> getUserByName(String name) async {
    try {
      String currentType = await getCurrentType();
      final userList = await ApplicationUserListQuery().loadNext();
      return userList.map((e) {
        if (e.nickname.contains(name) &&
            e.metaData['userType'] != currentType) {
          return e.toDomain();
        }
      }).toList();
    } catch (e) {
      Exception(e);
    }
  }

  // getUsersByType()
  Future<List<ChatUser>> getUsersByType() async {
    var currentType = await getCurrentType();
    print(currentType);
    final listQuery = ApplicationUserListQuery();
    try {
      var userList = await listQuery.loadNext();
      print('');
      var mapList = userList.map((e) {
        if (e.metaData['userType'] != currentType) {
          return e.toDomain();
        }
      }).toList();
      return mapList;
    } catch (e) {
      Exception(e);
    }
  }

  Future<List<ChatUser>> getDoctorBySpecialty(String specialty) async {
    try {
      final userList = await ApplicationUserListQuery().loadNext();
      return userList.map((e) {
        if (e.metaData['Specialty'] == specialty) {
          return e.toDomain();
        }
      }).toList();
    } catch (e) {
      Exception(e);
    }
  }
}
