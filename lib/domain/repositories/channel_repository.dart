import 'package:sendbirdtutorial/domain/entities/chat_channel.dart';
import 'package:sendbirdtutorial/domain/entities/chat_message.dart';
import 'package:sendbirdtutorial/domain/entities/chat_user.dart';

abstract class ChannelRepository {
  Future<List<ChatChannel>> getChannels();

  void createChannel(String userId);

  Stream<ChatChannel> getChannelsStream();

  Stream<ChatMessage> getMessageStream();

  ChatUser getCurrentUser();
}
