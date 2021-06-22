import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendbirdtutorial/domain/entities/chat_channel.dart';
import 'package:sendbirdtutorial/domain/entities/chat_message.dart';
import 'package:sendbirdtutorial/presentation/riverpod/chat_Notifier/chat.dart';

import '../../../main.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatChannel =
        ModalRoute.of(context).settings.arguments as ChatChannel;
    context.read(chatNotifier).setChannelUrl(chatChannel.url);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              child: Text(
                'U',
                style: TextStyle(fontSize: 12),
              ),
              backgroundColor: Colors.blue,
              maxRadius: 13,
            ),
            SizedBox(height: 3),
            Text(
              'My User',
              style: TextStyle(color: Colors.black87, fontSize: 12),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: Consumer(
                builder: (context, watch, child) {
                  return StreamBuilder(
                    initialData: [],
                    stream: watch(chatNotifier).onNewMessage,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        List<ChatMessage> list = snapshot.data;
                        return ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            return BuildChatMessage(list[index]);
                          },
                        );
                      }
                      return CircularProgressIndicator();
                    },
                  );
                },
              ),
            ),
            Divider(height: 1),
            Container(
              color: Colors.white,
              height: 50,
              child: InputChat(),
            ),
          ],
        ),
      ),
    );
  }
}

class InputChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: (val) {
                  context.read(chatNotifier).setMessage(val);
                },
                decoration: InputDecoration.collapsed(hintText: 'Send message'),
              ),
            ),
            Consumer(
              builder: (context, watch, child) {
                final state = watch(chatNotifier).getStatus;
                if (state == ChatStatus.Empty) {
                  return SendButton(true);
                } else if (state == ChatStatus.Send) {
                  return SendButton(true);
                } else if (state == ChatStatus.Sending) {
                  return SendButton(false);
                }
                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SendButton extends StatelessWidget {
  final bool available;

  const SendButton(this.available);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      child: IconButton(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        icon: Icon(
          Icons.send,
          color: available ? Colors.blue[400] : Colors.grey,
        ),
        onPressed: () {
          context.read(chatNotifier).sendMessage();
        },
      ),
    );
  }
}

class BuildChatMessage extends StatelessWidget {
  final ChatMessage message;

  const BuildChatMessage(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
      // TODO buscar el id de mas abajo - no puede existir cosas de sendbird en esta capa
      child: message.sender.userId == sendbird.currentUser.userId
          ? MyMessage(message.message)
          : NotMyMessage(message.message),
    );
  }
}

class MyMessage extends StatelessWidget {
  final String message;

  const MyMessage(this.message);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(message),
      ),
    );
  }
}

class NotMyMessage extends StatelessWidget {
  final String message;

  const NotMyMessage(this.message);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(message),
      ),
    );
  }
}
