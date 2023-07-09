import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home.dart';
import './registration.dart';

import '../../../common/snackbar.dart';

import '../../../blocs/signin/signin_barrel.dart';

class Login extends StatelessWidget {
  static const routeName = '/login';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void loginHandler(context) {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      BlocProvider.of<SignInBloc>(context).add(SignInRequest(
          email: _emailController.text, password: _passwordController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInStates>(
      listener: (context, state) {
        if (state is SignInLoading) {
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

        if (state is SignInFailed) {
          AppSnackBar.showSnackBar(context, Text(state.message));
        }

        if (state is SignInSuccess) {
          AppSnackBar.showSnackBar(context, Text("Success!"));

          Future.delayed(Duration(seconds: 1), () {
            Navigator.pushReplacementNamed(context, Home.routeName);
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(hintText: "Email ID"),
              ),
              TextField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(hintText: "Password"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(horizontal: 50))),
                  onPressed: () => loginHandler(context),
                  child: Text("Sign In"),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Don't have an account? "),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, Registration.routeName);
                      },
                      child: Text("Sign Up!"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
