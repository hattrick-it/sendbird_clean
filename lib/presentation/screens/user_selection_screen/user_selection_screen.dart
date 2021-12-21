import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/chat_user.dart';
import '../channels_list/channels_list_screen.dart';
import '../../viewmodel/auth_viewmodel/auth_viewmodel.dart';
import '../../viewmodel/user_selection_viewmodel/user_selection_viewmodel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserSelectionScreen extends ConsumerWidget {
  static const String routeName = '/user-selection-screen';

  const UserSelectionScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userType = ModalRoute.of(context)!.settings.arguments as String;
    ref.read(userSelectionViewModel).saveUserType(userType);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${AppLocalizations.of(context)!.userSelectionPageAppBarTitle} $userType'),
      ),
      body: Consumer(
        builder: (context, refProvider, child) {
          final providerState = refProvider.watch(authViewModel).getAuthState;
          if (providerState == AuthState.Empty) {
            return BuildUserSelectionBody(userType: userType);
          } else if (providerState == AuthState.Loaded) {
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

  const BuildUserSelectionBody({required this.userType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.read(userSelectionViewModel).getUsersByType(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ChatUser> list = snapshot.data as List<ChatUser>;
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

class BuildUserCard extends ConsumerWidget {
  final ChatUser chatUser;

  const BuildUserCard({required this.chatUser});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        var tempUser = await ref
            .read(authViewModel)
            .connect(chatUser.userId!, chatUser.nickname!);
      },
      child: ListTile(
        leading: CircleAvatar(
          maxRadius: 26,
          child: CircleAvatar(
            maxRadius: 25,
            backgroundImage: NetworkImage(chatUser.profileUrl!),
          ),
        ),
        title: chatUser.nickname != null || chatUser.nickname!.isNotEmpty
            ? Text(chatUser.nickname!)
            : Text(chatUser.userId!),
        subtitle:
            chatUser.metadata![AppLocalizations.of(context)!.doctorSpecialty] !=
                    null
                ? Text(chatUser
                    .metadata![AppLocalizations.of(context)!.doctorSpecialty]!)
                : Text(''),
      ),
    );
  }
}
