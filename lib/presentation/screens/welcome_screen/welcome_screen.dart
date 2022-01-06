import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendbirdtutorial/presentation/screens/welcome_screen/welcome_screen_button.dart';
import 'package:sendbirdtutorial/presentation/viewmodel/users_list_viewmodel/users_list_viewmodel.dart';
import '../../../Core/chat_assets.dart';
import '../../../Core/chat_colors.dart';
import '../../viewmodel/auth_viewmodel/auth_viewmodel.dart';
import '../doctors_list_screen/doctor_list_screen.dart';
import '../patients_list_screen/patients_list_screen.dart';

class WelcomeScreen extends ConsumerWidget {
  static const String routeName = '/welcome-screen';

  @override
  Widget build(BuildContext context, ref) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      ref.read(usersListViewModel).getUsers();
    });
    //TODO agregar un mensaje mientras se esta cargando usuarios (usar state del viewmodel), capaz LoginState?
    // TODO hablar con Juan, proponer a Dongsheng limpiar el codigo de backend de app, quitar commentarios
    // y prints, codigo comentado, etc
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
            builder: (context, ref, child) {
              var state = ref.watch(usersListViewModel).userListStatus;
              if (state == UserListStatus.Loading) {
                // return alert(context);
                return Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.black38.withAlpha(200),
                  child: Center(
                    child: alert(context),
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              var state = ref.watch(authViewModel).getState;
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
              return SizedBox.shrink();
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
      left: 20,
      right: 20,
      child: Container(
        width: 350,
        child: Text(
          AppLocalizations.of(context)!.welcomeScreenTitle,
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
  Widget build(BuildContext context, ref) {
    var viewmodel = ref.read(authViewModel);
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        BuildSelectorButton(
          title: AppLocalizations.of(context)!.selectionPagePatient,
          onPressed: () async {
            //TODO llevar a viewmodel (y todo el camino hasta el repository), un metodo que
            // elija random entre pacientes o doctores segun el boton, uno para loguearse
            // SACAR LOGICA DE LA VISTA !!!!!!
            var chatUser = await ref
                .read(authViewModel)
                .connect('Patient_3', 'Michael Williams', 'Patient');
            if (chatUser != null) {
              Navigator.of(context).pushNamed(DoctorListScreen.routeName,
                  arguments: AppLocalizations.of(context)!.userTypePatient);
            }
          },
          buttonColor: ChatColors.notMyMsgColor,
          textColor: ChatColors.whiteColor,
        ),
        SizedBox(height: 20),
        BuildSelectorButton(
          title: AppLocalizations.of(context)!.selectionPageDoctor,
          onPressed: () async {
            var chatUser = await ref
                .read(authViewModel)
                .connect('Doctor_2', 'Andrea Miller.', 'Doctor');
            if (chatUser != null) {
              Navigator.of(context).pushNamed(PatientsListScreen.routeName,
                  arguments: AppLocalizations.of(context)!.userTypePatient);
            }
          },
          buttonColor: ChatColors.welcomeScreenWhiteButton,
          textColor: ChatColors.blackColor,
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

AlertDialog alert(BuildContext context) {
  return AlertDialog(
    title: Center(
      child: Text(AppLocalizations.of(context)!.welcome_screen_alert_title),
    ),
    content: Container(
      height: 150,
      child: Column(
        children: [
          Align(
              alignment: Alignment.center,
              child: Text(
                  AppLocalizations.of(context)!.welcome_screen_alert_text)),
          Expanded(
            child: SizedBox.expand(),
          ),
          Center(
            child: Container(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Colors.purple,
                strokeWidth: 2,
              ),
            ),
          ),
          Expanded(
            child: SizedBox.expand(),
          ),
          Text(AppLocalizations.of(context)!.welcome_screen_alert_dismiss_text),
        ],
      ),
    ),
    actions: [],
  );
}
