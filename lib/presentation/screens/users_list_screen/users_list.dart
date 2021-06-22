import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendbirdtutorial/domain/entities/chat_user.dart';
import 'package:sendbirdtutorial/presentation/riverpod/users_list_notifier/users_list.dart';
import 'package:sendbirdtutorial/presentation/riverpod/users_list_notifier/users_list_states.dart';

class UsersListScreen extends StatelessWidget {
  const UsersListScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BuildChannelListBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read(usersListNotifier).getUsers();
        },
        child: Text('Add'),
      ),
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
          final state = watch(usersListNotifier.state);
          if (state is UsersListLoading) {
            return CircularProgressIndicator();
          }
          if (state is UsersListLoaded) {
            return BuildUsersList(state.usersList);
          }
          print(state);
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
          onTap: (){
            context.read(usersListNotifier).createChannel(usersList[index].userId);
          },
          child: ListTile(
            title: CircleAvatar(child: Text(usersList[index].userId),),
          ),
        );
      },
    );
  }
}
