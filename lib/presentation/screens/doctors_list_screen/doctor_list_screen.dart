import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:sendbirdtutorial/Core/chat_colors.dart';
import 'package:sendbirdtutorial/domain/entities/chat_user.dart';
import 'package:sendbirdtutorial/presentation/screens/common_widgets/common_appbar.dart';
import 'package:sendbirdtutorial/presentation/viewmodel/user_selection_viewmodel/user_selection_viewmodel.dart';
import '../../../domain/entities/chat_doctor.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

var docList = [
  ChatDoctor(
      userId: 'doctor1',
      nickname: 'Dr.Edwin Ching',
      isOnline: true,
      profileUrl:
          'https://res.cloudinary.com/hattrick-it/image/upload/v1624907937/users/doctor_1.jpg',
      specialty: 'General Practice'),
  ChatDoctor(
      userId: 'doctor2',
      nickname: 'Dr.Kevin Zeng',
      isOnline: true,
      profileUrl:
          'https://res.cloudinary.com/hattrick-it/image/upload/v1624907946/users/doctor_2.jpg',
      specialty: 'Hospitalist'),
  ChatDoctor(
      userId: 'doctor3',
      nickname: 'Dr.John Shi Chang Su',
      isOnline: false,
      profileUrl:
          'https://res.cloudinary.com/hattrick-it/image/upload/v1624907952/users/doctor_3.jpg',
      specialty: 'Family Medicine'),
  ChatDoctor(
      userId: 'doctor4',
      nickname: 'Dr.Jun Qi Wu.',
      isOnline: true,
      profileUrl:
          'https://res.cloudinary.com/hattrick-it/image/upload/v1624907937/users/doctor_1.jpg',
      specialty: 'Family Medicine'),
  ChatDoctor(
      userId: 'doctor1',
      nickname: 'Dr.Edwin Ching',
      isOnline: true,
      profileUrl:
          'https://res.cloudinary.com/hattrick-it/image/upload/v1624907937/users/doctor_1.jpg',
      specialty: 'General Practice'),
  ChatDoctor(
      userId: 'doctor2',
      nickname: 'Dr.Kevin Zeng',
      isOnline: true,
      profileUrl:
          'https://res.cloudinary.com/hattrick-it/image/upload/v1624907946/users/doctor_2.jpg',
      specialty: 'Hospitalist'),
  ChatDoctor(
      userId: 'doctor3',
      nickname: 'Dr.John Shi Chang Su',
      isOnline: false,
      profileUrl:
          'https://res.cloudinary.com/hattrick-it/image/upload/v1624907952/users/doctor_3.jpg',
      specialty: 'Family Medicine'),
  ChatDoctor(
      userId: 'doctor4',
      nickname: 'Dr.Jun Qi Wu.',
      isOnline: true,
      profileUrl:
          'https://res.cloudinary.com/hattrick-it/image/upload/v1624907937/users/doctor_1.jpg',
      specialty: 'Family Medicine'),
];

class DoctorListScreen extends StatelessWidget {
  static const String routeName = '/doctor-list-screen';

  @override
  Widget build(BuildContext context) {
    final userType = ModalRoute.of(context).settings.arguments as String;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read(userSelectionViewModel).getUsersByType();
    });

    return Scaffold(
      appBar: CommonAppbar(
        title: AppLocalizations.of(context).doctorListScreenAppbarTitle,
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
          height: 60,
          padding: EdgeInsets.symmetric(vertical: 10),
          color: ChatColors.greyAppbarBackgroundColor,
          child: SpecialtyButtonsComponent(),
        ),
        Consumer(
          builder: (context, watch, child) {
            var provider = watch(userSelectionViewModel);
            if (provider.getUserList == null) {
              return Center(child: CircularProgressIndicator());
            } else if (provider.getUserSelectionSatus ==
                UserSelectionStatus.Loaded) {
              return DoctorsList(userList: provider.getUserList);
            }
            return Center(child: CircularProgressIndicator());
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
                onTap: () {},
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

class SpecialtyButtonsComponent extends StatelessWidget {
  const SpecialtyButtonsComponent();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read(userSelectionViewModel).getSpecialtyList();
      context.read(userSelectionViewModel).getSpecialtyMap();
    });

    return Container(
      height: 40,
      margin: EdgeInsets.only(left: 15),
      child: Consumer(
        builder: (context, watch, child) {
          final status = watch(userSelectionViewModel).getSpecialtyListStatus;
          if (status == SpecialtyListStatus.Loaded) {
            final specialties = watch(userSelectionViewModel).getSpecialties;
            final specialtiesMap =
                watch(userSelectionViewModel).getSpecialtiesMap;
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
                      ? ChatColors.specialtySelected
                      : ChatColors.specialtyUnSelected,
                  child: FlatButton(
                    onPressed: () {
                      context.read(userSelectionViewModel).getDoctorBySpecialty(index);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(specialtiesMap.keys.elementAt(index)),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return LinearProgressIndicator();
        },
      ),
    );
  }
}

class DoctorsList extends StatelessWidget {
  final List<ChatUser> userList;

  const DoctorsList({this.userList});

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
          return Container(
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
                        // Text(
                        //   userList[index].specialty,
                        //   style: TextStyle(fontWeight: FontWeight.bold),
                        // ),
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
          );
        },
      ),
    );
  }
}
