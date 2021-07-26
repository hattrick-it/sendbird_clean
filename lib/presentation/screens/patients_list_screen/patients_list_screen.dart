import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/chat_user.dart';
import '../channels_list/channels_list_screen.dart';
import '../../viewmodel/auth_viewmodel/auth_viewmodel.dart';
import '../../viewmodel/user_selection_viewmodel/user_selection_viewmodel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PatientsListScreen extends StatelessWidget {
  static const String routeName = '/patients-list-screen';

  const PatientsListScreen();

  @override
  Widget build(BuildContext context) {
    final userType = ModalRoute.of(context).settings.arguments as String;
    context.read(userSelectionViewModel).saveUserType(userType);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${AppLocalizations.of(context).userSelectionPageAppBarTitle} $userType'),
      ),
      body: Consumer(
        builder: (context, watch, child) {
          final providerState = watch(authViewModel).getState;
          if (providerState == LoginState.Empty) {
            return BuildUserSelectionBody(userType: userType);
          } else if (providerState == LoginState.Loaded) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              Navigator.of(context)
                  .popAndPushNamed(ChannelListScreen.routeName);
            });
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class BuildUserSelectionBody extends ConsumerWidget {
  final String userType;

  const BuildUserSelectionBody({this.userType});

  @override
  Widget build(BuildContext context, watch) {
    return FutureBuilder(
      future: context.read(userSelectionViewModel).getUsersByType(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ChatUser> list = snapshot.data;
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return SlideInRight(
                delay: Duration(milliseconds: index * 150),
                from: 350,
                child: BuildUserCard(chatUser: list[index]),
              );
            },
          );
        }
        return Center(child: Center(child: CircularProgressIndicator()));
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
        subtitle: chatUser
                    .metadata[AppLocalizations.of(context).doctorSpecialty] !=
                null
            ? Text(
                chatUser.metadata[AppLocalizations.of(context).doctorSpecialty])
            : Text(''),
      ),
    );
  }
}
