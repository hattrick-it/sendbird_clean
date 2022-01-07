import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../Core/chat_colors.dart';
import '../../../domain/entities/chat_user.dart';
import '../../viewmodel/user_selection_viewmodel/user_selection_viewmodel.dart';
import '../../viewmodel/users_list_viewmodel/users_list_viewmodel.dart';
import '../chat_screen/chat_screen.dart';
import '../common_widgets/common_appbar.dart';

class DoctorListScreen extends ConsumerWidget {
  static const String routeName = '/doctor-list-screen';

  @override
  Widget build(BuildContext context, ref) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ref.read(userSelectionViewModel).getUsersByType();
    });

    return Scaffold(
      appBar: CommonAppbar(
        title: AppLocalizations.of(context)!.doctorListScreenAppbarTitle,
        appbarColor: ChatColors.greyAppbarBackgroundColor,
      ),
      body: BuildDoctorListBody(),
    );
  }
}

class BuildDoctorListBody extends StatelessWidget {
  const BuildDoctorListBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchComponent(),
        Container(
          height: 70,
          child: Container(
            height: 60,
            padding: EdgeInsets.only(bottom: 22, top: 10),
            color: ChatColors.greyAppbarBackgroundColor,
            child: SpecialtyButtonsComponent(),
          ),
        ),
        Consumer(
          builder: (context, ref, child) {
            var provider = ref.watch(userSelectionViewModel);
            if (provider.getUserList == null) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    ChatColors.purpleAppbarBackgroundColor,
                  ),
                ),
              );
            } else if (provider.getUserSelectionSatus ==
                UserSelectionStatus.Loaded) {
              return DoctorsList(userList: provider.getUserList);
            }
            return Center(
              child: Container(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    ChatColors.purpleAppbarBackgroundColor,
                  ),
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

class BuildSearchBar extends ConsumerWidget {
  const BuildSearchBar();

  @override
  Widget build(BuildContext context, ref) {
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
                  ref.read(userSelectionViewModel).getUserByName(val);
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 7),
                  alignLabelWithHint: true,
                  hintText:
                      AppLocalizations.of(context)!.doctorListScreenHinttext,
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

class SpecialtyButtonsComponent extends ConsumerWidget {
  const SpecialtyButtonsComponent();

  @override
  Widget build(BuildContext context, ref) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ref.read(userSelectionViewModel).getSpecialtyMap();
    });

    return Container(
      height: 40,
      margin: EdgeInsets.only(left: 15),
      child: Consumer(
        builder: (context, ref, child) {
          final status =
              ref.watch(userSelectionViewModel).getSpecialtyListStatus;
          if (status == SpecialtyListStatus.Loaded) {
            final specialtiesMap =
                ref.watch(userSelectionViewModel).getSpecialtiesMap;
            return ListView.separated(
              separatorBuilder: (context, index) {
                return Divider(
                  thickness: 2,
                  endIndent: 5,
                );
              },
              scrollDirection: Axis.horizontal,
              itemCount: specialtiesMap.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  color: specialtiesMap.values.elementAt(index)
                      ? ChatColors.notMyMsgColor
                      : ChatColors.whiteColor,
                  child: TextButton(
                    onPressed: () {
                      ref
                          .read(userSelectionViewModel)
                          .getDoctorBySpecialty(index);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          specialtiesMap.keys.elementAt(index),
                          style: TextStyle(
                            fontSize: 11,
                            color: specialtiesMap.values.elementAt(index)
                                ? ChatColors.whiteColor
                                : ChatColors.doctorsubtitleText,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Center(
            child: Container(
              height: 10,
              width: 10,
              child: CircularProgressIndicator(
                strokeWidth: 1,
                valueColor: AlwaysStoppedAnimation<Color>(
                    ChatColors.purpleAppbarBackgroundColor),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DoctorsList extends ConsumerWidget {
  final List<ChatUser> userList;

  const DoctorsList({required this.userList});

  @override
  Widget build(BuildContext context, ref) {
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
              var groupChannel = await ref
                  .read(usersListViewModel)
                  .getChannelByIds(userList[index].userId!);
              if (groupChannel != null) {
                Navigator.of(context)
                    .pushNamed(ChatScreen.routeName, arguments: groupChannel);
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
                      image: NetworkImage(userList[index].profileUrl!),
                      foregroundDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ChatColors.greyAppbarBackgroundColor,
                          width: 1.0,
                        ),
                      ),
                      size: 60,
                      statusSize: 16,
                      statusColor: userList[index].isOnline!
                          ? ChatColors.doctorAvailable
                          : ChatColors.doctorNotAvailable,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          userList[index].metadata!['Specialty'] != null
                              ? Text(
                                  userList[index].metadata!['Specialty']!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                )
                              : Container(),
                          Text(
                            userList[index].nickname!,
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
