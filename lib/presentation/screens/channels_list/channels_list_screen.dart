import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../Core/chat_colors.dart';
import '../../../domain/entities/chat_channel.dart';
import '../../../domain/entities/chat_user.dart';
import '../chat_screen/chat_screen.dart';
import '../../viewmodel/channel_list_viewmodel/chat_channel_list_viewmodel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChannelListScreen extends ConsumerWidget {
  static const String routeName = '/channel-list';

  @override
  Widget build(BuildContext context, ref) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {});
    ChatUser chatUser = ref.read(chatChannelViewModel).getCurrentUser();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          chatUser.nickname!,
          style: TextStyle(fontSize: 14),
        ),
        centerTitle: true,
      ),
      body: BuildChannelListBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.of(context).pushNamed(UsersListScreen.routeName);
        },
        child: Text('Add'),
      ),
    );
  }
}

class BuildChannelListBody extends ConsumerWidget {
  const BuildChannelListBody();

  @override
  Widget build(BuildContext context, ref) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {});

    return StreamBuilder(
      stream: ref.read(chatChannelViewModel).onNewChannelEvent,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ChatChannel> channelList = snapshot.data as List<ChatChannel>;
          return ListView.builder(
            itemCount: channelList.length,
            itemBuilder: (context, index) {
              var chatUser = ref.read(chatChannelViewModel).getCurrentUser();
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
                        channelList[index].members![0].userId == chatUser.userId
                            ? Image.network(
                                channelList[index].members![1].profileUrl!)
                            : Image.network(
                                channelList[index].members![0].profileUrl!),
                  ),
                  title:
                      channelList[index].members![0].userId == chatUser.userId
                          ? Text(channelList[index].members![1].nickname!)
                          : Text(channelList[index].members![0].nickname!),
                  trailing: channelList[index].lastMessage != null
                      ? Text(channelList[index].lastMessage!.message!)
                      : Text(AppLocalizations.of(context)!
                          .channelScreenNoMessagesYet),
                ),
              );
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
                ChatColors.purpleAppbarBackgroundColor),
          ),
        );
      },
    );
  }
}
