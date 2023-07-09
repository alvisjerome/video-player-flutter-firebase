import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/signout/signout_barrel.dart';
import '../../common/snackbar.dart';
import '../widgets/player.dart';
import './authentication/login.dart';

class Home extends StatelessWidget {
  static const routeName = "/home";

  const Home();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignOutBloc, SignOutStates>(
      listener: (context, state) {
        if (state is SignOutLoading) {
          AppSnackBar.showSnackBar(
              context,
              Row(
                children: [
                  CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text("Loading.."),
                  )
                ],
              ));
        }

        if (state is SignOutFailed) {
          AppSnackBar.showSnackBar(context, Text(state.message));
        }

        if (state is SignOutSuccess) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          Navigator.of(context).pushNamedAndRemoveUntil(
              Login.routeName, (Route<dynamic> route) => false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("YellowClass"),
          centerTitle: true,
          actions: [
            PopupMenuButton(
                itemBuilder: (context) => [
                      PopupMenuItem(
                        child: TextButton.icon(
                            onPressed: () {
                              BlocProvider.of<SignOutBloc>(context)
                                  .add(SignOutRequest());
                            },
                            icon: Icon(Icons.logout),
                            label: Text("Sign Out")),
                        value: 1,
                      ),
                    ])
          ],
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Welcome!\nPress the below button to play video.",
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).accentColor)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Player()));
                },
                icon: Icon(Icons.play_arrow_sharp),
                label: Text("Play Video"))
          ],
        )),
      ),
    );
  }
}
