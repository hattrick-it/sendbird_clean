import 'dart:async';

import 'package:sendbird_sdk/sendbird_sdk.dart';

import '../../../Core/string_constants.dart';
import '../../../domain/entities/chat_message.dart';
import '../../../domain/entities/chat_user.dart';
import '../../../domain/repositories/chat_repository.dart';
import '../../data_sources/local_data_source/user_type_data_source.dart';
import '../../data_sources/remote_data_source/chat_data_source.dart';
import '../../data_sources/remote_data_source/models/baseMessage.dart';
import '../../data_sources/remote_data_source/models/user.dart';
import '../../data_sources/remote_data_source/users_data_source.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource chatRemoteDataSource;
  final UserTypeDataSource userTypeDataSource;
  final UsersDataSource usersDataSource;

  ChatRepositoryImpl({
    required this.chatRemoteDataSource,
    required this.userTypeDataSource,
    required this.usersDataSource,
  });

  @override
  Stream<ChatMessage> getMessageStream() {
    return chatRemoteDataSource.getMessageStream
        .map((baseMessage) => baseMessage.toDomain());
  }

  @override
  Future<List<ChatUser>> getUsers() async {
    var currentUserType = await userTypeDataSource.getCurrentUserType();
    try {
      List<User> users = await usersDataSource.getUsers();
      var chatUsers = users.map((e) => e.toDomain()).toList();
      var usersList = chatUsers.where((element) =>
          element.metadata!.containsKey(StringConstants.userTypeKey) &&
          element.metadata![StringConstants.userTypeKey] != currentUserType);
      return usersList.toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  void setChannelUrl(String channelUrl) {
    chatRemoteDataSource.setChannelUrl(channelUrl);
  }

  @override
  Future<ChatMessage> sendMessage(String message) {
    return chatRemoteDataSource
        .sendMessage(message)
        .then((message) => message!.toDomain());
  }

  ChatUser getCurrentUser() {
    return usersDataSource.getCurrentUser()!.toDomain();
  }

  @override
  Future<List<ChatMessage>> getMessagesList() async {
    var baseMessages = await chatRemoteDataSource.getMessages();
    return baseMessages.map((e) => e.toDomain()).toList();
  }
}
