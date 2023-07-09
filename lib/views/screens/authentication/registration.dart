import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home.dart';
import './login.dart';

import '../../../blocs/signup/signin_barrel.dart';

import '../../../common/snackbar.dart';

class Registration extends StatelessWidget {
  static const routeName = '/registration';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void registrationHandler(context) {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      BlocProvider.of<SignUpBloc>(context).add(SignUpRequest(
          email: _emailController.text, password: _passwordController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpStates>(
      listener: (context, state) {
        if (state is SignUpLoading) {
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

        if (state is SignUpFailed) {
          AppSnackBar.showSnackBar(context, Text(state.message));
        }

        if (state is SignUpSuccess) {
          AppSnackBar.showSnackBar(context, Text("Success!"));

          Future.delayed(Duration(seconds: 1), () {
            Navigator.pushReplacementNamed(context, Home.routeName);
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Registeration"),
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
                    onPressed: () => registrationHandler(context),
                    child: Text("Sign Up")),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Already have an account? "),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, Login.routeName);
                      },
                      child: Text("Sign In"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
