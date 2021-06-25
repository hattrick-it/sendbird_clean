import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendbirdtutorial/domain/entities/chat_user.dart';
import 'package:sendbirdtutorial/presentation/riverpod/users_list_notifier/users_list_notifier.dart';

class UsersListScreen extends StatelessWidget {
  const UsersListScreen();

  @override
  Widget build(BuildContext context) {
    context.read(usersListNotifier).getUsers();
    return Scaffold(
      appBar: AppBar(),
      body: BuildChannelListBody(),
    );
  }
}

class BuildChannelListBody extends StatelessWidget {
  const BuildChannelListBody();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer(
        builder: (context, watch, child) {
          final provider = watch(usersListNotifier);
          if (provider.userListStatus == UserListStatus.Loaded) {
            return BuildUsersList(provider.usersList);
          } else if (provider.userListStatus == UserListStatus.Loading) {
            return CircularProgressIndicator();
          } else if (provider.userListStatus == UserListStatus.Error) {
            return Center(child: Text(provider.errorMsg));
          }
          return Container();
        },
      ),
    );
  }
}

class BuildUsersList extends StatelessWidget {
  final List<ChatUser> usersList;

  const BuildUsersList(this.usersList);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: usersList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            context
                .read(usersListNotifier)
                .createChannel(usersList[index].userId);
          },
          child: ListTile(
            title: CircleAvatar(
              child: Text(usersList[index].userId),
            ),
          ),
        );
      },
    );
  }
}
