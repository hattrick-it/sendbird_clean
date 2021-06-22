import 'package:sendbirdtutorial/domain/repositories/channel_repository.dart';

import '../../entities/chat_channel.dart';

import '../../../locator/locator.dart';

class ChannelListController {
  static final ChannelListController _chatUseCasesSingleton =
      ChannelListController._internal();

  factory ChannelListController() {
    return _chatUseCasesSingleton;
  }

  ChannelListController._internal();

  final ChannelRepository _channelRepository = locator.get<ChannelRepository>();

  Future<List<ChatChannel>> getChannels() async {
    return await _channelRepository.getChannels();
  }

  void createChannel(String userId) {
    _channelRepository.createChannel(userId);
  }

  Stream<void> getStreamMessages() {
    return _channelRepository.getMessageStream();
  }
}
