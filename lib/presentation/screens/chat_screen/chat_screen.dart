import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../Core/chat_colors.dart';
import '../../../domain/entities/chat_channel.dart';
import '../../../domain/entities/chat_message.dart';
import '../../../domain/entities/chat_user.dart';
import '../../viewmodel/chat_viewmodel/chat_viewmodel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatScreen extends ConsumerWidget {
  static const String routeName = '/chat-screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatChannel =
        ModalRoute.of(context)!.settings.arguments as ChatChannel;
    ref.read(chatViewModel).setChannelUrl(chatChannel.channelUrl!);
    var currentUser = ref.read(chatViewModel).getCurrentUser();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ChatColors.whiteColor,
        title: Column(
          children: [
            CircleAvatar(
              child: chatChannel.members![0].userId == currentUser.userId
                  ? Text('${chatChannel.members![1].nickname![0]}',
                      style: TextStyle(fontSize: 12))
                  : Text('${chatChannel.members![0].nickname![0]}',
                      style: TextStyle(fontSize: 12)),
              backgroundColor: ChatColors.primaryColor,
              maxRadius: 13,
            ),
            SizedBox(height: 3),
            chatChannel.members![0].userId == currentUser.userId
                ? Text(chatChannel.members![1].nickname!,
                    style:
                        TextStyle(color: ChatColors.blackColor, fontSize: 12))
                : Text(chatChannel.members![0].nickname!,
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
                    stream: ref.watch(chatViewModel).onNewMessage,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        if (snapshot.hasData) {
                          List<ChatMessage>? list =
                              snapshot.data as List<ChatMessage>?;
                          var reversed = list!.reversed.toList();
                          return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            reverse: true,
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              return BuildChatMessage(reversed[index]);
                            },
                          );
                        }
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
              builder: (context, ref, child) {
                final provider = ref.watch(chatViewModel);
                ctrl.text = provider.getMsg;
                return Expanded(
                  child: TextField(
                    controller: ctrl,
                    onChanged: (val) {
                      ref.read(chatViewModel).setUserMsg(val);
                    },
                    decoration: InputDecoration.collapsed(
                        hintText: AppLocalizations.of(context)!
                            .chatScreenSendButtonText),
                  ),
                );
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                final provider = ref.watch(chatViewModel);
                if (provider.chatState == ChatState.Empty) {
                  return SendButton(true);
                } else if (provider.chatState == ChatState.Send) {
                  return SendButton(true);
                } else if (provider.chatState == ChatState.Sending) {
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

class SendButton extends ConsumerWidget {
  final bool available;
  const SendButton(this.available);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          ref.read(chatViewModel).sendMessage();
          ref.read(chatViewModel).clearMsg();
        },
      ),
    );
  }
}

class BuildChatMessage extends ConsumerWidget {
  final ChatMessage message;

  const BuildChatMessage(this.message);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ChatUser currentUser = ref.read(chatViewModel).getCurrentUser();
    return Container(
      child: message.sender!.userId == currentUser.userId
          ? MyMessage(message.message!)
          : NotMyMessage(message.message!),
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
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: ChatColors.myMsgColor,
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
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: ChatColors.notMyMsgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(message),
      ),
    );
  }
}
