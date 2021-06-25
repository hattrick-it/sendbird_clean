import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendbirdtutorial/presentation/riverpod/channel_list_notifier/chat_channel_list_notifier.dart';

class ChannelListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read(chatChannelNotifier).loadChannelsList();
    context.read(chatChannelNotifier).listenStream();
    return Scaffold(
      appBar: AppBar(),
      body: Consumer(
        builder: (context, watch, child) {
          final provider = watch(chatChannelNotifier);
          if (provider.chatChannelState ==  ChatChannelState.Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.chatChannelState ==  ChatChannelState.Loaded) {
            var channelList = provider.channelList;
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
