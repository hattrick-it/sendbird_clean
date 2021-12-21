import 'package:flutter/material.dart';
import '../../../Core/chat_colors.dart';
import '../../../Core/chat_resources.dart';
import '../../../domain/entities/chat_doctor.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

var docList = [
  ChatDoctor(
      userId: 'doctor1',
      nickname: 'Dr.Edwin Ching MBBS,MRCP,GDOM',
      isOnline: true,
      profileUrl: '',
      specialty: 'General Practice'),
  ChatDoctor(
      userId: 'doctor2',
      nickname: 'Dr.Kevin Zeng M.D.',
      isOnline: true,
      profileUrl: '',
      specialty: 'Hospitalist'),
  ChatDoctor(
      userId: 'doctor3',
      nickname: 'Dr.John Shi Chang Su MBBS,GDFM,GDOM',
      isOnline: false,
      profileUrl: '',
      specialty: 'Family Medicine'),
  ChatDoctor(
      userId: 'doctor4',
      nickname: 'Dr.Jun Qi Wu M.D.',
      isOnline: false,
      profileUrl: '',
      specialty: 'Family Medicine'),
];

class DoctorSelectorScreen extends StatelessWidget {
  static const String routeName = '/doctor-selector-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: ChatColors.doctorAppbarBackground,
        title: Text(
          AppLocalizations.of(context)!.doctor_selector_providers,
          style: TextStyle(fontSize: 15),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              AppLocalizations.of(context)!.doctor_selector_specialty,
              style: TextStyle(
                fontSize: 15,
                color: ChatColors.whiteColor,
              ),
            ),
          ),
        ],
      ),
      body: DoctorSelectorBody(),
    );
  }
}

class DoctorSelectorBody extends StatelessWidget {
  const DoctorSelectorBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BuildSearchBar(),
        BuildSubTitle(),
        BuildDoctorsList(),
      ],
    );
  }
}

class BuildSearchBar extends StatelessWidget {
  const BuildSearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      color: ChatColors.doctorSearchBar,
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: ChatColors.whiteColor,
        ),
        child: Row(
          children: [
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

class BuildSubTitle extends StatelessWidget {
  const BuildSubTitle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      color: ChatColors.doctorSubTitleBackground,
      child: Row(
        children: [
          SizedBox(width: 10),
          Text(
            AppLocalizations.of(context)!.doctor_selector_select_provider,
            style: TextStyle(color: ChatColors.doctorsubtitleText),
          ),
        ],
      ),
    );
  }
}

class BuildDoctorsList extends StatelessWidget {
  const BuildDoctorsList();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: docList.length,
      itemBuilder: (context, index) {
        return BuildDoctorCard(
          doctor: docList[index],
        );
      },
    );
  }
}

class BuildDoctorCard extends StatelessWidget {
  final ChatDoctor doctor;

  const BuildDoctorCard({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 80,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.all(5),
              height: 80,
              width: 80,
              child: doctor.profileUrl!.isNotEmpty
                  ? Image.asset(doctor.profileUrl!)
                  : Image.asset(ChatResources.profileUrlPlaceholder),
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.nickname!,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    doctor.specialty!,
                    style: TextStyle(color: ChatColors.primaryColor),
                  ),
                  doctor.isOnline!
                      ? Text(
                          AppLocalizations.of(context)!
                              .doctor_selector_available_now,
                          style: TextStyle(color: ChatColors.doctorAvailable),
                        )
                      : Text(
                          AppLocalizations.of(context)!
                              .doctor_selector_select_schedule_visits,
                          style:
                              TextStyle(color: ChatColors.doctorNotAvailable),
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
