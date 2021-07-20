import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbirdtutorial/Core/string_constants.dart';
import 'package:sendbirdtutorial/data/data_sources/remote_data_source/users_data_source.dart';
import '../../data_sources/local_data_source/user_type_data_source.dart';
import '../../../domain/entities/chat_message.dart';
import '../../../domain/entities/chat_user.dart';
import '../../data_sources/remote_data_source/chat_data_source.dart';
import '../../../domain/repositories/chat_repository.dart';
import '../../data_sources/remote_data_source/models/baseMessage.dart';
import '../../data_sources/remote_data_source/models/user.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatDataSource sendbirdChannelsDataSource;
  final UserTypeDataSource localUserTypeDataSource;
  final UsersDataSource usersDataSource;

  ChatRepositoryImpl(
      {this.sendbirdChannelsDataSource,
      this.localUserTypeDataSource,
      this.usersDataSource});

  @override
  Stream<ChatMessage> getMessageStream() {
    return sendbirdChannelsDataSource.getMessageStream
        .map((baseMessages) => baseMessages.toDomain());
  }

  @override
  Future<List<ChatUser>> getUsers() async {
    var currentUserType = await localUserTypeDataSource.getCurrentUserType();
    try {
      List<User> users = await usersDataSource.getUsers();
      var chatUsers = users.map((e) => e.toDomain()).toList();
      return chatUsers.where((element) =>
          element.metadata[StringConstants.userTypeKey] != currentUserType &&
          element.metadata.length > 0);
    } catch (e) {
      throw Exception(e);
    }
  }

  void setChannelUrl(String channelUrl) {
    sendbirdChannelsDataSource.setChannelUrl(channelUrl);
  }

  @override
  Future<ChatMessage> sendMessage(String message) {
    return sendbirdChannelsDataSource
        .sendMessage(message)
        .then((message) => message.toDomain());
  }

  @override
  ChatUser getCurrentUser() {
    return usersDataSource.getCurrentUser().toDomain();
  }

  @override
  Future<List<ChatMessage>> getMessagesList() async {
    var baseMessages = await sendbirdChannelsDataSource.getMessages();
    return baseMessages.map((e) => e.toDomain()).toList();
  }
}
