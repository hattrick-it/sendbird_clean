import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sendbirdtutorial/Core/string_constants.dart';
import '../../../Core/chat_assets.dart';
import '../../../Core/chat_colors.dart';
import '../../../domain/entities/chat_channel.dart';
import '../../../domain/entities/chat_message.dart';
import '../../viewmodel/chat_viewmodel/chat_viewmodel.dart';

class ChatScreen extends ConsumerWidget {
  static const String routeName = '/chat-screen';

  @override
  Widget build(BuildContext context, ref) {
    final chatChannel =
        ModalRoute.of(context)!.settings.arguments as ChatChannel;
    ref.read(chatViewModel).setChannelUrl(chatChannel.channelUrl!);
    ref.read(chatViewModel).setCurrentUser();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: ChatColors.darckGrey,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: ChatColors.whiteColor,
        actions: [
          Icon(
            Icons.info_outline,
            color: ChatColors.notMyMsgColor,
          ),
          SizedBox(width: 10),
        ],
        title: Column(
          children: [
            CircleAvatar(
              child: chatChannel.members![0].userId ==
                      ref.read(chatViewModel).getCurrentUser!.userId
                  ? Text('${chatChannel.members![1].nickname![0]}',
                      style: TextStyle(fontSize: 12))
                  : Text('${chatChannel.members![0].nickname![0]}',
                      style: TextStyle(fontSize: 12)),
              backgroundColor: ChatColors.notMyMsgColor,
              maxRadius: 10,
            ),
            SizedBox(height: 3),
            chatChannel.members![0].userId ==
                    ref.read(chatViewModel).getCurrentUser!.userId
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
                        List<ChatMessage> list =
                            snapshot.data as List<ChatMessage>;
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
                      return Center(
                          child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            ChatColors.purpleAppbarBackgroundColor),
                      ));
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

class InputChat extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
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
                    style: TextStyle(
                      height: 1,
                    ),
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
            SendButton(),
          ],
        ),
      ),
    );
  }
}

class SendButton extends ConsumerWidget {
  const SendButton();

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      child: IconButton(
        highlightColor: ChatColors.transparentColor,
        splashColor: ChatColors.transparentColor,
        icon: Icon(
          Icons.send,
          color: ChatColors.purpleAppbarBackgroundColor,
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
  Widget build(BuildContext context, ref) {
    return Container(
      child: message.sender!.userId ==
              ref.read(chatViewModel).getCurrentUser!.userId
          ? MyMessage(message)
          : NotMyMessage(message),
    );
  }
}

class NotMyMessage extends StatelessWidget {
  final ChatMessage chatMessage;

  const NotMyMessage(this.chatMessage);

  @override
  Widget build(BuildContext context) {
    var created = chatMessage.createdAt;
    var date = DateTime.fromMillisecondsSinceEpoch(created!);
    var formattedDate = DateFormat('hh:mm a').format(date);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 45,
                    ),
                    chatMessage.sender!.userId !=
                            StringConstants.baseMessageAdminKey
                        ? Text(
                            chatMessage.sender!.nickname ?? '',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: ChatColors.doctorSearchBar,
                            ),
                          )
                        : Text(
                            AppLocalizations.of(context)!.chatScreenWebAdmin,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: ChatColors.doctorSearchBar,
                            ),
                          ),
                  ],
                ),
                Row(
                  children: [
                    chatMessage.sender!.userId !=
                            StringConstants.baseMessageAdminKey
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                maxRadius: 14,
                                backgroundColor:
                                    ChatColors.greyAppbarBackgroundColor,
                                child: CircleAvatar(
                                    maxRadius: 13,
                                    backgroundImage: NetworkImage(
                                        chatMessage.sender!.profileUrl!)),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                maxRadius: 14,
                                backgroundColor:
                                    ChatColors.greyAppbarBackgroundColor,
                                child: CircleAvatar(
                                  maxRadius: 13,
                                  backgroundImage: AssetImage(
                                      ChatAssets.profileUrlPlaceholder),
                                ),
                              ),
                            ],
                          ),
                    Container(
                      constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: ChatColors.myMsgColor,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        chatMessage.message ?? '',
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          formattedDate,
                          style: TextStyle(
                            fontSize: 10,
                            color: ChatColors.doctorSearchBar,
                          ),
                        ),
                      ],
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

class MyMessage extends StatelessWidget {
  final ChatMessage chatMessage;

  const MyMessage(this.chatMessage);

  @override
  Widget build(BuildContext context) {
    var created = chatMessage.createdAt;
    var date = DateTime.fromMillisecondsSinceEpoch(created!);
    var formattedDate = DateFormat('hh:mm a').format(date);
    return Align(
      alignment: Alignment.bottomRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 20,
              ),
              chatMessage.sendingStatus == MsgSendingStatus.pending
                  ? FaIcon(
                      FontAwesomeIcons.check,
                      size: 12,
                      color: ChatColors.checkColor,
                    )
                  : FaIcon(
                      FontAwesomeIcons.checkDouble,
                      size: 12,
                      color: ChatColors.checkColor,
                    ),
              Text(
                formattedDate,
                style: TextStyle(
                  fontSize: 10,
                  color: ChatColors.doctorSearchBar,
                ),
              ),
            ],
          ),
          Container(
            constraints: BoxConstraints(minWidth: 10, maxWidth: 200),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ChatColors.notMyMsgColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              chatMessage.message ?? '',
              maxLines: 3,
              style: TextStyle(
                color: ChatColors.whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
