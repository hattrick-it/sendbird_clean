import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/chat_user.dart';
import '../../viewmodel/users_list_viewmodel/users_list_viewmodel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UsersListScreen extends ConsumerWidget {
  static const String routeName = '/users-list-screen';
  const UsersListScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ref.read(usersListViewModel).getUsers();
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.usersListPageAppBarTitle),
      ),
      body: BuildChannelListBody(),
    );
  }
}

class BuildChannelListBody extends ConsumerWidget {
  const BuildChannelListBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Consumer(
        builder: (context, watch, child) {
          final provider = ref.watch(usersListViewModel);
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

class BuildUsersList extends ConsumerWidget {
  final List<ChatUser> usersList;

  const BuildUsersList(this.usersList);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: usersList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            ref
                .read(usersListViewModel)
                .createChannel(usersList[index].userId!);
          },
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(usersList[index].profileUrl!),
            ),
            title: Text(usersList[index].nickname!),
          ),
        );
      },
    );
  }
}
