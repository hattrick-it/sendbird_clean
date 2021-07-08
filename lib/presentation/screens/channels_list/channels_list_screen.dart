import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/chat_channel.dart';
import '../../../domain/entities/chat_user.dart';
import '../chat_screen/chat_screen.dart';
import '../users_list_screen/users_list.dart';
import '../../viewmodel/channel_list_viewmodel/chat_channel_list_viewmodel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChannelListScreen extends StatelessWidget {
  static const String routeName = '/channel-list';
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {});
    ChatUser chatUser = context.read(chatChannelNotifier).getCurrentUser();
    return Scaffold(
      appBar: AppBar(
        title: Text(chatUser.nickname),
      ),
      body: BuildChannelListBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(UsersListScreen.routeName);
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
    WidgetsBinding.instance?.addPostFrameCallback((_) {});

    return StreamBuilder(
      stream: context.read(chatChannelNotifier).onNewChannelEvent,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var channelList = snapshot.data as List<ChatChannel>;
          return ListView.builder(
            itemCount: channelList.length,
            itemBuilder: (context, index) {
              var chatUser = context.read(chatChannelNotifier).getCurrentUser();
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(ChatScreen.routeName,
                      arguments: channelList[index]);
                },
                child: ListTile(
                  leading: Container(
                    height: 40,
                    width: 40,
                    child:
                        channelList[index].members[0].userId == chatUser.userId
                            ? Image.network(
                                channelList[index].members[1].profileUrl)
                            : Image.network(
                                channelList[index].members[0].profileUrl),
                  ),
                  title: channelList[index].members[0].userId == chatUser.userId
                      ? Text(channelList[index].members[1].nickname)
                      : Text(channelList[index].members[0].nickname),
                  trailing: Text(channelList[index].lastMessage.message),
                ),
              );
            },
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
