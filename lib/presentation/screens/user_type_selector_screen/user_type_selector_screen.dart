import 'package:flutter/material.dart';
import 'package:sendbirdtutorial/data/data_sources/remote_data_source/user_batch_data_entry.dart';
import '../../../Core/chat_colors.dart';
import '../user_selection_screen/user_selection_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserSelectorScreen extends StatelessWidget {
  static const String routeName = '/user-type-selector';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: UserSelectorBody()),
    );
  }
}

class UserSelectorBody extends StatelessWidget {
  const UserSelectorBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BuildTitle(),
        SizedBox(height: 100),
        BuildSelectorButtons(),
        // BuildLoadDummyDataButton(),
      ],
    );
  }
}

class BuildTitle extends StatelessWidget {
  const BuildTitle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context).selectionPageTelemedicine,
            style: TextStyle(fontSize: 40),
          ),
          Text(
            AppLocalizations.of(context).selectionPageDemostrator,
            style: TextStyle(fontSize: 40),
          ),
        ],
      ),
    );
  }
}

class BuildSelectorButtons extends StatelessWidget {
  const BuildSelectorButtons();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BuildSelectorButton(
          title: AppLocalizations.of(context).selectionPagePatient,
          onPressed: () {
            Navigator.of(context).popAndPushNamed(UserSelectionScreen.routeName,
                arguments: AppLocalizations.of(context).userTypePatient);
          },
        ),
        BuildSelectorButton(
          title: AppLocalizations.of(context).selectionPageDoctor,
          onPressed: () {
            Navigator.of(context).popAndPushNamed(UserSelectionScreen.routeName,
                arguments: AppLocalizations.of(context).userTypeDoctor);
          },
        ),
      ],
    );
  }
}

class BuildSelectorButton extends StatelessWidget {
  final String title;
  final GestureTapCallback onPressed;

  const BuildSelectorButton({this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 4,
          shadowColor: ChatColors.disbleSendButton,
          primary: ChatColors.whiteColor,
          side: BorderSide(
            width: 2,
            color: ChatColors.blackColor,
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(color: ChatColors.blackColor),
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
          elevation: 4,
          shadowColor: ChatColors.disbleSendButton,
          primary: ChatColors.whiteColor,
          side: BorderSide(
            width: 2,
            color: ChatColors.blackColor,
          ),
        ),
        onPressed: (){
          var batchClass = UserBatchDataEntry();
          batchClass.createPatients();
          batchClass.createDoctors();
        },
        child: Text(
          AppLocalizations.of(context).selectionPageLoadDummyData,
          style: TextStyle(color: ChatColors.blackColor),
        ),
      ),
    );
  }
}
