import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbirdtutorial/data/data_sources/remote_data_source/sendbird_channels_remote_data_source.dart';
import 'package:sendbirdtutorial/domain/entities/chat_channel.dart';
import 'package:sendbirdtutorial/domain/entities/chat_message.dart';
import 'package:sendbirdtutorial/domain/repositories/channel_repository.dart';
import 'package:sendbirdtutorial/data/data_sources/remote_data_source/models/sendbird_base_message.dart';
import 'package:sendbirdtutorial/data/data_sources/remote_data_source/models/sendbird_chat_channel.dart';
import 'package:sendbirdtutorial/locator/locator.dart';

class ChannelRepositoryImpl implements ChannelRepository {
  final SendbirdChannelsDataSource _sendbirdChannelsDataSource =
      locator.get<SendbirdChannelsDataSource>();

  @override
  void createChannel(String userId) async {
    List<String> userIds = [];
    User current = await _sendbirdChannelsDataSource.getCurrentUser();
    userIds.add(current.userId);
    userIds.add(userId);
    _sendbirdChannelsDataSource.createChannel(userIds);
  }

  void getChatChannel() {
    // TODO: implement getChatChannel
    throw UnimplementedError();
  }

  @override
  Future<List<ChatChannel>> getChannels() async {
    List<GroupChannel> groupChannelList =
        await _sendbirdChannelsDataSource.getGroupChannels();
    List<ChatChannel> chatChannelsList = [];
    for (var item in groupChannelList) {
      chatChannelsList.add(ChatChannel(
        url: item.channelUrl,
        name: item.name,
        data: item.data,
        coverUrl: item.coverUrl,
      ));
    }
    return chatChannelsList;
  }

  @override
  Stream<ChatMessage> getMessageStream() {
    return _sendbirdChannelsDataSource.onNewMsg
        .map((event) => event.toDomain());
  }

  @override
  Stream<ChatChannel> getChannelsStream() {
    return _sendbirdChannelsDataSource.onChannelMsg
        .map((event) => event.toDomain());
  }
}
