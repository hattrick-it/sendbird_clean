import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/chat_user.dart';
import '../channels_list/channels_list_screen.dart';
import '../../viewmodel/auth_viewmodel/auth_viewmodel.dart';
import '../../viewmodel/user_selection_viewmodel/user_selection_viewmodel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserSelectionScreen extends StatelessWidget {
  static const String routeName = '/user-selection-screen';
  const UserSelectionScreen();

  @override
  Widget build(BuildContext context) {
    final userType = ModalRoute.of(context).settings.arguments as String;
    context.read(userSelectionNotifier).saveUserType(userType);
    return Scaffold(
      appBar: AppBar(
        title: Text('${AppLocalizations.of(context).userSelectionPageAppBarTitle} $userType'),
      ),
      body: BuildUserSelectionBody(userType: userType),
    );
  }
}

class BuildUserSelectionBody extends StatelessWidget {
  final String userType;

  const BuildUserSelectionBody({this.userType});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read(userSelectionNotifier).getUsersByType(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ChatUser> list = snapshot.data;
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return BuildUserCard(chatUser: list[index]);
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class BuildUserCard extends StatelessWidget {
  final ChatUser chatUser;

  const BuildUserCard({this.chatUser});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var tempUser = await context
            .read(authNotifierProvider)
            .connect(chatUser.userId, chatUser.nickname);
        if (tempUser != null) {
          Navigator.of(context).popAndPushNamed(ChannelListScreen.routeName);
        }
      },
      child: ListTile(
        leading: CircleAvatar(
          maxRadius: 26,
          child: CircleAvatar(
            maxRadius: 25,
            backgroundImage: NetworkImage(chatUser.profileUrl),
          ),
        ),
        title: chatUser.nickname != null || chatUser.nickname.isNotEmpty
            ? Text(chatUser.nickname)
            : Text(chatUser.userId),
        subtitle: chatUser.metadata[AppLocalizations.of(context).doctorSpecialty] != null
            ? Text(chatUser.metadata[AppLocalizations.of(context).doctorSpecialty])
            : Text(''),
      ),
    );
  }
}
