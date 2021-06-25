import 'package:flutter/material.dart';

class UserSelectorScreen extends StatelessWidget {
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
        SizedBox(height: 50),
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
      child: Text(
        'Telemedicine Demostrator',
        style: TextStyle(fontSize: 40),
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
            Navigator.of(context).pushNamed('patient-selector');
          },
        ),
        BuildSelectorButton(
          title: 'Iam a Doctor',
          onPressed: () {
            Navigator.of(context).pushNamed('/doctor-selector');
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
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(title),
    );
  }
}
