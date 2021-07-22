import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../Core/chat_colors.dart';
import '../../../domain/entities/chat_channel.dart';
import '../../../domain/entities/chat_message.dart';
import '../../../domain/entities/chat_user.dart';
import '../../viewmodel/chat_viewmodel/chat_viewmodel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = '/chat-screen';

  @override
  Widget build(BuildContext context) {
    final chatChannel =
        ModalRoute.of(context).settings.arguments as ChatChannel;
    context.read(chatViewModel).setChannelUrl(chatChannel.channelUrl);
    var currentUser = context.read(chatViewModel).getCurrentUser();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ChatColors.whiteColor,
        title: Column(
          children: [
            CircleAvatar(
              child: chatChannel.members[0].userId == currentUser.userId
                  ? Text('${chatChannel.members[1].nickname[0]}',
                      style: TextStyle(fontSize: 12))
                  : Text('${chatChannel.members[0].nickname[0]}',
                      style: TextStyle(fontSize: 12)),
              backgroundColor: ChatColors.primaryColor,
              maxRadius: 13,
            ),
            SizedBox(height: 3),
            chatChannel.members[0].userId == currentUser.userId
                ? Text(chatChannel.members[1].nickname,
                    style:
                        TextStyle(color: ChatColors.blackColor, fontSize: 12))
                : Text(chatChannel.members[0].nickname,
                    style:
                        TextStyle(color: ChatColors.blackColor, fontSize: 12)),
          ],
        ),
        iconTheme: IconThemeData(color: ChatColors.primaryColor),
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
                    stream: watch(chatViewModel).onNewMessage,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        List<ChatMessage> list = snapshot.data;
                        var reversed = list.reversed.toList();
                        return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          reverse: true,
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            return BuildChatMessage(reversed[index]);
                          },
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  );
                },
              ),
            ),
            Divider(height: 1),
            Container(
              color: ChatColors.whiteColor,
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
    TextEditingController ctrl = TextEditingController();
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Consumer(
              builder: (context, watch, child) {
                final provider = watch(chatViewModel);
                ctrl.text = provider.getMsg;
                return Expanded(
                  child: TextField(
                    controller: ctrl,
                    onChanged: (val) {
                      context.read(chatViewModel).setUserMsg(val);
                    },
                    decoration: InputDecoration.collapsed(
                        hintText: AppLocalizations.of(context)
                            .chatScreenSendButtonText),
                  ),
                );
              },
            ),
            Consumer(
              builder: (context, watch, child) {
                final provider = watch(chatViewModel);
                if (provider.chatState == ChatState.Empty) {
                  return SendButton(true);
                } else if (provider.chatState == ChatState.Send) {
                  return SendButton(true);
                } else if (provider.chatState == ChatState.Sending ||
                    provider.getMsg.isEmpty) {
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
        highlightColor: ChatColors.transparentColor,
        splashColor: ChatColors.transparentColor,
        icon: Icon(
          Icons.send,
          color: available
              ? ChatColors.enableSendButton
              : ChatColors.disbleSendButton,
        ),
        onPressed: () {
          context.read(chatViewModel).sendMessage();
          context.read(chatViewModel).clearMsg();
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
    final ChatUser currentUser = context.read(chatViewModel).getCurrentUser();
    return Container(
      child: message.sender.userId == currentUser.userId
          ? MyMessage(message)
          : NotMyMessage(message),
    );
  }
}

class MyMessage extends StatelessWidget {
  final ChatMessage chatMessage;

  const MyMessage(this.chatMessage);

  @override
  Widget build(BuildContext context) {
    var date =
        DateTime.fromMillisecondsSinceEpoch(chatMessage.createdAt * 1000);
    var formattedDate = DateFormat('h:mm a').format(date);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            CircleAvatar(
              maxRadius: 21,
              backgroundColor: ChatColors.greyAppbarBackgroundColor,
              child: CircleAvatar(
                maxRadius: 20,
                backgroundImage: NetworkImage(chatMessage.sender.profileUrl),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chatMessage.sender.nickname,
                  style: TextStyle(
                    fontSize: 12,
                    color: ChatColors.disbleSendButton,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: ChatColors.myMsgColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(chatMessage.message),
                    ),
                    Text(
                      formattedDate,
                      style: TextStyle(
                        fontSize: 10,
                        color: ChatColors.disbleSendButton,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NotMyMessage extends StatelessWidget {
  final ChatMessage chatMessage;

  const NotMyMessage(this.chatMessage);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: ChatColors.notMyMsgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          chatMessage.message,
          style: TextStyle(color: ChatColors.whiteColor),
        ),
      ),
    );
  }
}
