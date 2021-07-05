import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbirdtutorial/data/data_sources/local_data_source/local_user_type_data_source.dart';
import 'package:sendbirdtutorial/domain/entities/chat_message.dart';
import 'package:sendbirdtutorial/domain/entities/chat_user.dart';
import '../../data_sources/remote_data_source/sendbird_chat_remote_data_source.dart';
import '../../../domain/repositories/chat_repository.dart';
import 'package:sendbirdtutorial/data/data_sources/remote_data_source/models/sendbird_base_message.dart';
import 'package:sendbirdtutorial/data/data_sources/remote_data_source/models/sendbird_user.dart';

class ChatRepositoryImpl implements ChatRepository {
  final SendbirdChatRemoteDataSource sendbirdChannelsDataSource;
  final LocalUserTypeDataSource localUserTypeDataSource;

  ChatRepositoryImpl({this.sendbirdChannelsDataSource, this.localUserTypeDataSource});

  @override
  Stream<List<ChatMessage>> getMessageStream() {
    return sendbirdChannelsDataSource
        .getMessagesStream.map((baseMessages) =>
        baseMessages.map((baseMessage) => baseMessage.toDomain()).toList());
  }

  @override
  Future<List<ChatUser>> getUsers() async {
    var currentUserType = await localUserTypeDataSource.getCurrentUserType();
    try {
      List<User> users = await sendbirdChannelsDataSource.getUsers();
      var chatUserList = users.map((e) => e.toDomain()).toList();
      List<ChatUser> chatUsers = [];
      for (var item in chatUserList) {
        if (item.metadata['userType'] != currentUserType &&
            item.metadata.length > 0) {
          chatUsers.add(item);
        }
      }
      return chatUsers;
    } catch (e) {
      throw Exception(e);
    }
  }

  void setChannelUrl(String channelUrl) {
    sendbirdChannelsDataSource.setChannelUrl(channelUrl);
  }

  @override
  Future<void> sendMessage(String message) {
    return sendbirdChannelsDataSource.sendMessage(message);
  }

  @override
  ChatUser getCurrentUser() {
    return sendbirdChannelsDataSource.getCurrentUser().toDomain();
  }

  @override
  Future<List<ChatMessage>> getMessagesList() async {
    var baseMessages = await sendbirdChannelsDataSource.getMessages();
    return baseMessages.map((e) => e.toDomain()).toList();
  }
}
