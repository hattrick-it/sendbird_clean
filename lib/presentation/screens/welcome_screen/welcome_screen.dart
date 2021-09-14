import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendbirdtutorial/Core/chat_assets.dart';
import 'package:sendbirdtutorial/data/data_sources/remote_data_source/user_batch_data_entry.dart';
import 'package:sendbirdtutorial/presentation/screens/doctors_list_screen/doctor_list_screen.dart';
import 'package:sendbirdtutorial/presentation/screens/patients_list_screen/patients_list_screen.dart';
import 'package:sendbirdtutorial/presentation/viewmodel/auth_viewmodel/auth_viewmodel.dart';
import '../../../Core/chat_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomeScreen extends StatelessWidget {
  static const String routeName = '/welcome-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ChatAssets.welcomeScreenBackgroundImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BuildTitle(),
          Positioned(
            bottom: 60,
            left: 30,
            right: 30,
            child: BuildSelectorButtons(),
          ),
          Consumer(
            builder: (context, watch, child) {
              var state = watch(authViewModel).getState;
              if (state == LoginState.Loading) {
                return Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.black38.withAlpha(200),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          ChatColors.purpleAppbarBackgroundColor),
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}

class BuildTitle extends StatelessWidget {
  const BuildTitle();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 110,
      left: 50,
      child: Container(
        width: 350,
        child: Text(
          AppLocalizations.of(context).welcomeScreenTitle,
          style: TextStyle(
            fontSize: 44,
            fontWeight: FontWeight.bold,
            color: ChatColors.whiteColor,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class BuildSelectorButtons extends ConsumerWidget {
  const BuildSelectorButtons();

  @override
  Widget build(BuildContext context, watch) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        BuildSelectorButton(
          title: AppLocalizations.of(context).selectionPagePatient,
          onPressed: () async {
            var chatUser = await context
                .read(authViewModel)
                .connect('Patient_3', 'Michael Williams', 'Patient');
            if (chatUser != null) {
              Navigator.of(context).pushNamed(DoctorListScreen.routeName,
                  arguments: AppLocalizations.of(context).userTypePatient);
            }
          },
          buttonColor: ChatColors.notMyMsgColor,
          textColor: ChatColors.whiteColor,
        ),
        SizedBox(height: 20),
        BuildSelectorButton(
          title: AppLocalizations.of(context).selectionPageDoctor,
          onPressed: () async {
            var chatUser = await context
                .read(authViewModel)
                .connect('Doctor_2', 'Andrea Miller.', 'Doctor');
            if (chatUser != null) {
              Navigator.of(context).pushNamed(PatientsListScreen.routeName,
                  arguments: AppLocalizations.of(context).userTypeDoctor);
            }
          },
          buttonColor: ChatColors.welcomeScreenWhiteButton,
          textColor: ChatColors.blackColor,
        ),
        SizedBox(height: 20),
        BuildLoadDummyDataButton(),
      ],
    );
  }
}

class BuildSelectorButton extends StatelessWidget {
  final String title;
  final GestureTapCallback onPressed;
  final Color buttonColor;
  final Color textColor;

  const BuildSelectorButton({
    this.title,
    this.onPressed,
    this.buttonColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 70,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: ChatColors.disbleSendButton,
          primary: buttonColor,
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

class BuildLoadDummyDataButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: ChatColors.disbleSendButton,
          primary: ChatColors.whiteColor,
          side: BorderSide(
            width: 2,
            color: ChatColors.blackColor,
          ),
        ),
        onPressed: () async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
          var batchClass = UserBatchDataEntry();
          await context.read(authViewModel).connect('admin', 'admin', 'admin');
          var dbExists = await batchClass.dbExists();
          if (!dbExists) {
            await batchClass.createPatients();
            await batchClass.createDoctors();
          }
        },
        child: Text(
          AppLocalizations.of(context).selectionPageLoadDummyData,
          style: TextStyle(color: ChatColors.blackColor),
        ),
      ),
    );
  }

  AlertDialog alert = AlertDialog(
    title: Text("Adding users"),
    content: Text(
        "Wait a minute while users are created and press outside this box to dismiss."),
    actions: [],
  );
}
