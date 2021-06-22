import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbirdtutorial/domain/entities/chat_message.dart';
import 'package:sendbirdtutorial/domain/entities/chat_user.dart';
import 'package:sendbirdtutorial/locator/locator.dart';
import '../../data_sources/remote_data_source/sendbird_chat_remote_data_source.dart';
import '../../../domain/repositories/chat_repository.dart';
import 'package:sendbirdtutorial/data/data_sources/remote_data_source/models/sendbird_base_message.dart';
import 'package:sendbirdtutorial/data/data_sources/remote_data_source/models/sendbird_user.dart';

class ChatRepositoryImpl implements ChatRepository {
  final SendbirdChatRemoteDataSource _sendbirdChannelsDataSource =
      locator.get<SendbirdChatRemoteDataSource>();

  @override
  Future<Stream<List<ChatMessage>>> getMessageStream() {
    return _sendbirdChannelsDataSource
        .initializeStream()
        .then((streamMessages) {
      return streamMessages.map((baseMessages) =>
          baseMessages.map((baseMessage) => baseMessage.toDomain()).toList());
    });
  }

  @override
  Future<List<ChatUser>> getUsers() async {
    try {
      List<User> users = await _sendbirdChannelsDataSource.getUsers();
      List<ChatUser> chatUsers = [];
      for (var item in users) {
        chatUsers.add(item.toDomain());
      }
      return chatUsers;
    } catch (e) {
      throw Exception(e);
    }
  }

  void setChannelUrl(String channelUrl) {
    _sendbirdChannelsDataSource.setChannelUrl(channelUrl);
  }

  @override
  Future<void> sendMessage(String message) {
    return _sendbirdChannelsDataSource.sendMessage(message);
  }
}
