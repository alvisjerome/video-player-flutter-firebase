import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import './app/app.dart';

import './utils/observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = AppBlocObserver();
  runApp(App());
}
