import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../riverpod/auth_notifier/auth_notifier.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hattrick-IT'),
      ),
      body: Consumer(
        builder: (context, watch, child) {
          final state = watch(authNotifierProvider).getAuthState;
          if (state == AuthStates.Empty) {
            return BuildInitial();
          } else if (state == AuthStates.Loaded) {
            // TODO check w/Gaston how to fix this issue(navigator inside a delay)
            Future.delayed(Duration.zero, () {
              Navigator.of(context).pushNamed('/channel-list');
            });
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class BuildError extends StatelessWidget {
  final String message;

  const BuildError(this.message);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(message),
          ),
          RaisedButton(
            onPressed: () {},
            child: Text('back'),
          ),
        ],
      ),
    );
  }
}

class BuildInitial extends StatelessWidget {
  const BuildInitial();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UserIdField(),
          NicknameField(),
          SignInButton(),
        ],
      ),
    );
  }
}

class UserIdField extends StatelessWidget {
  const UserIdField();

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        context.read(authNotifierProvider).setUserId = value;
      },
      obscureText: false,
      decoration: InputDecoration(
        labelText: 'User ID',
      ),
    );
  }
}

class NicknameField extends StatelessWidget {
  const NicknameField();

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        context.read(authNotifierProvider).setNickname = value;
      },
      obscureText: false,
      decoration: InputDecoration(
        labelText: 'Nickname',
      ),
    );
  }
}

class SignInButton extends StatelessWidget {
  const SignInButton();

  @override
  Widget build(BuildContext context) {
    return new ElevatedButton(
      child: Text('Sign in'),
      onPressed: () {
        context.read(authNotifierProvider).connect();
      },
    );
  }
}
