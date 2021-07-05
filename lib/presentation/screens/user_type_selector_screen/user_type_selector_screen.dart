import 'package:flutter/material.dart';
import 'package:sendbirdtutorial/Core/chat_colors.dart';
import 'package:sendbirdtutorial/presentation/screens/user_selection_screen/user_selection_screen.dart';

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
            'Telemedicine',
            style: TextStyle(fontSize: 40),
          ),
          Text(
            'Demostrator',
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
          title: 'Iam a Patient',
          onPressed: () {
            Navigator.of(context).popAndPushNamed(UserSelectionScreen.routeName,
                arguments: 'Patient');
          },
        ),
        BuildSelectorButton(
          title: 'Iam a Doctor',
          onPressed: () {
            Navigator.of(context).popAndPushNamed(UserSelectionScreen.routeName,
                arguments: 'Doctor');
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
