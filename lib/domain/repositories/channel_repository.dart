import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbirdtutorial/domain/entities/chat_channel.dart';
import 'package:sendbirdtutorial/domain/entities/chat_message.dart';

abstract class ChannelRepository {
  Future<List<ChatChannel>> getChannels();

  void createChannel(String userId);

  Stream<ChatMessage> getMessageStream();

  Stream<ChatChannel> getChannelsStream();
}
