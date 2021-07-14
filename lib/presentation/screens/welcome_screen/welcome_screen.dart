import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendbirdtutorial/Core/chat_assets.dart';
import 'package:sendbirdtutorial/data/data_sources/remote_data_source/user_batch_data_entry.dart';
import 'package:sendbirdtutorial/presentation/screens/doctors_list_screen/doctor_list_screen.dart';
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
      top: 100,
      left: 30,
      child: Container(
        width: 350,
        child: Text(
          AppLocalizations.of(context).welcomeScreenTitle,
          style: TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.bold,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(1.5, 1.5),
                blurRadius: 5.0,
                color: ChatColors.whiteColor,
              ),
              Shadow(
                offset: Offset(3.0, 3.0),
                blurRadius: 8.0,
                color: ChatColors.whiteColor,
              ),
            ],
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
            await context
                .read(authNotifierProvider)
                .connect('Patient_3', 'Black Widow', 'Patient');

            Navigator.of(context).pushNamed(DoctorListScreen.routeName,
                arguments: AppLocalizations.of(context).userTypePatient);
          },
          buttonColor: ChatColors.welcomeScreenPurpleButton,
          textColor: ChatColors.whiteColor,
        ),
        SizedBox(height: 20),
        BuildSelectorButton(
          title: AppLocalizations.of(context).selectionPageDoctor,
          onPressed: () {},
          buttonColor: ChatColors.welcomeScreenWhiteButton,
          textColor: ChatColors.blackColor,
        ),
        // SizedBox(height: 50),
        // BuildLoadDummyDataButton(),
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
  const BuildLoadDummyDataButton();

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
        onPressed: () {
          // var batchClass = SendbirdUserSelectionDataSource();
          // batchClass.createPatients();
          // batchClass.createDoctors();
        },
        child: Text(
          AppLocalizations.of(context).selectionPageLoadDummyData,
          style: TextStyle(color: ChatColors.blackColor),
        ),
      ),
    );
  }
}