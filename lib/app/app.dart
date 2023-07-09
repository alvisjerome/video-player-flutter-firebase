import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/signin/signin_bloc.dart';
import '../blocs/signout/signout_bloc.dart';
import '../blocs/signup/signup_bloc.dart';
import '../routes/router.dart';
import '../services/auth.dart';
import '../styles/colors.dart';
import '../views/screens/authentication/login.dart';
import '../views/screens/fault.dart';
import '../views/screens/home.dart';

class App extends StatelessWidget {
  final _authenticationServices = AuthenticationService(FirebaseAuth.instance);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignInBloc(_authenticationServices),
        ),
        BlocProvider(
          create: (context) => SignUpBloc(_authenticationServices),
        ),
        BlocProvider(
          create: (context) => SignOutBloc(_authenticationServices),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'YellowClass',
          theme: ThemeData(
            primaryColor: AppColors.primaryColor,
            accentColor: AppColors.accentColor,
          ),
          home: const _AuthenticationWrapper(),
          routes: AppRouter.allRoutes,
          onUnknownRoute: (settings) {
            return MaterialPageRoute(builder: (context) => Fault());
          }),
    );
  }
}

//[AuthenticationWrapper] to check if user is already logged in or not.

class _AuthenticationWrapper extends StatelessWidget {
  const _AuthenticationWrapper();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AuthenticationService(FirebaseAuth.instance).authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Fault();
          }
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data != null) {
              return Home();
            } else {
              return Login();
            }
          }

          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
