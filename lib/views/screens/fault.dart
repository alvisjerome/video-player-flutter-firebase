import 'package:flutter/material.dart';

class Fault extends StatelessWidget {
  static const routeName = '/fault';
  const Fault();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Something went wrong!"),
      ),
    );
  }
}
