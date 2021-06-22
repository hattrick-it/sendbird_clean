import 'package:sendbirdtutorial/domain/entities/chat_message.dart';
import 'package:sendbirdtutorial/domain/entities/chat_user.dart';
import 'package:sendbirdtutorial/domain/repositories/chat_repository.dart';
import 'package:sendbirdtutorial/locator/locator.dart';

class ChatController {
  final ChatRepository _chatRepository = locator.get<ChatRepository>();

  Future<List<ChatUser>> getUsers() {
    return _chatRepository.getUsers();
  }

  Future<void> sendMessage(String message) {
    return _chatRepository.sendMessage(message);
  }

  void setChannelUrl(String channelUrl) {
    _chatRepository.setChannelUrl(channelUrl);
  }

  Future<Stream<List<ChatMessage>>> streamMessages() {
    return _chatRepository.getMessageStream();
  }
}
