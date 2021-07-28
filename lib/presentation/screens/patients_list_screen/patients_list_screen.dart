import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:sendbirdtutorial/Core/chat_colors.dart';
import 'package:sendbirdtutorial/domain/entities/chat_user.dart';
import 'package:sendbirdtutorial/presentation/screens/chat_screen/chat_screen.dart';
import 'package:sendbirdtutorial/presentation/screens/common_widgets/common_appbar.dart';
import 'package:sendbirdtutorial/presentation/viewmodel/user_selection_viewmodel/user_selection_viewmodel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sendbirdtutorial/presentation/viewmodel/users_list_viewmodel/users_list_viewmodel.dart';

class PatientsListScreen extends StatelessWidget {
  static const String routeName = '/patient-list-screen';

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read(userSelectionViewModel).getUsersByType();
    });

    return Scaffold(
      appBar: CommonAppbar(
        title: AppLocalizations.of(context).patientListScreenAppbarTitle,
        appbarColor: ChatColors.greyAppbarBackgroundColor,
      ),
      body: BuildPatientsListBody(),
    );
  }
}

class BuildPatientsListBody extends StatelessWidget {
  const BuildPatientsListBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchComponent(),

        Consumer(
          builder: (context, watch, child) {
            var provider = watch(userSelectionViewModel);
            if (provider.getUserList == null) {
              return Center(child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    ChatColors.purpleAppbarBackgroundColor),
              ));
            } else if (provider.getUserSelectionSatus ==
                UserSelectionStatus.Loaded) {
              return PatientsList(userList: provider.getUserList);
            }
            return Center(
              child: Container(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      ChatColors.purpleAppbarBackgroundColor),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class SearchComponent extends StatelessWidget {
  const SearchComponent();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      color: ChatColors.greyAppbarBackgroundColor,
      child: Column(
        children: [
          BuildSearchBar(),
        ],
      ),
    );
  }
}

class BuildSearchBar extends StatelessWidget {
  const BuildSearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 50,
      color: ChatColors.greyAppbarBackgroundColor,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: ChatColors.whiteColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                style:
                TextStyle(color: ChatColors.disbleSendButton, fontSize: 12),
                cursorColor: ChatColors.disbleSendButton,
                onChanged: (val) {
                  context.read(userSelectionViewModel).getUserByName(val);
                },
                decoration: InputDecoration(
                  hintText:
                  AppLocalizations.of(context).doctorListScreenHinttext,
                  border: InputBorder.none,
                ),
              ),
            ),
            Icon(
              Icons.search,
              color: ChatColors.doctorSearchBar,
            ),
          ],
        ),
      ),
    );
  }
}


class PatientsList extends StatelessWidget {
  final List<ChatUser> userList;

  const PatientsList({this.userList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: userList.length,
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return Divider(
            thickness: 1,
          );
        },
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              var gropuChannel = await context
                  .read(usersListViewModel)
                  .getChannelByIds(userList[index].userId);
              if (gropuChannel != null) {
                Navigator.of(context)
                    .pushNamed(ChatScreen.routeName, arguments: gropuChannel);
              }
            },
            child: Container(
              width: double.infinity,
              height: 90,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 5),
                    child: AdvancedAvatar(
                      image: NetworkImage(userList[index].profileUrl),
                      foregroundDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ChatColors.greyAppbarBackgroundColor,
                          width: 1.0,
                        ),
                      ),
                      size: 60,
                      statusSize: 16,
                      statusColor: userList[index].isOnline
                          ? ChatColors.doctorAvailable
                          : ChatColors.doctorNotAvailable,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          userList[index].metadata['Specialty'] != null
                              ? Text(
                            userList[index].metadata['Specialty'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                              : Container(),
                          Text(
                            userList[index].nickname,
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}