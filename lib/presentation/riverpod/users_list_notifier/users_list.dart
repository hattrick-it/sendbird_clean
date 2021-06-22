import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendbirdtutorial/domain/entities/chat_user.dart';
import 'package:sendbirdtutorial/domain/use_cases/channel_list_use_case/channel_list_controller.dart';
import 'package:sendbirdtutorial/domain/use_cases/chat_use_case/chat_controller.dart';
import 'package:sendbirdtutorial/locator/locator.dart';
import 'package:sendbirdtutorial/presentation/riverpod/users_list_notifier/users_list_states.dart';

final usersListNotifier = StateNotifierProvider((ref) => UsersListNotifier());

class UsersListNotifier extends StateNotifier<UsersListStates> {
  UsersListNotifier() : super(UsersListInitial());

  final ChatController _chatController = locator.get<ChatController>();
  final ChannelListController _channelListController =
      locator.get<ChannelListController>();

  void createChannel(String userId) {
    _channelListController.createChannel(userId);
  }

  void getUsers() async {
    try {
      state = UsersListLoading();
      List<ChatUser> usersList = await _chatController.getUsers();
      if (usersList.length > 0) {
        state = UsersListLoaded(usersList);
      } else {
        state = UsersListInitial();
      }
    } catch (e) {
      state = UsersListError(e.toString());
    }
  }
}
