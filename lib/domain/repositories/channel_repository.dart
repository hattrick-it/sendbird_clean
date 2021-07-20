import '../entities/chat_channel.dart';
import '../entities/chat_message.dart';
import '../entities/chat_user.dart';

abstract class ChannelRepository {
  Future<List<ChatChannel>> getChannels();

  Future<ChatChannel> createChannel(String userId);

  Stream<ChatChannel> getChannelsStream();

  Stream<ChatMessage> getMessageStream();

  ChatUser getCurrentUser();

  Future<ChatChannel> getChannelByIds(String userId);
}
