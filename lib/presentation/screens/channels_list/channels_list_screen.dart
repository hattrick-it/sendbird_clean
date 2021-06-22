import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendbirdtutorial/presentation/riverpod/channel_list_notifier/chat_channel_list.dart';
import 'package:sendbirdtutorial/presentation/riverpod/channel_list_notifier/chat_channel_list_states.dart';

class ChannelListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read(chatChannelNotifier).loadChannelsList();
    context.read(chatChannelNotifier).listenStream();
    return Scaffold(
      appBar: AppBar(),
      body: Consumer(
        builder: (context, watch, child) {
          final state = watch(chatChannelNotifier.state);
          if (state is ChatChannelsListLoading) {
            return CircularProgressIndicator();
          } else if (state is ChatChannelsListLoaded) {
            var channelList = state.channels;
            return ListView.builder(
              itemCount: channelList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/chat-screen', arguments: channelList[index]);
                  },
                  child: ListTile(
                    title: Text(channelList[index].url),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/users-list-screen');
        },
        child: Text('Add'),
      ),
    );
  }
}
