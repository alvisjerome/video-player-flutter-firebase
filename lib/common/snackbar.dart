import 'package:flutter/material.dart';

abstract class AppSnackBar {
  static void showSnackBar(BuildContext context, Widget child) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: child));
  }
}
