import 'package:flutter/widgets.dart';

import '../views/screens/authentication/login.dart';
import '../views/screens/authentication/registration.dart';
import '../views/screens/fault.dart';
import '../views/screens/home.dart';

abstract class AppRouter {
  static final allRoutes = {
    Home.routeName: (BuildContext context) => Home(),
    Login.routeName: (BuildContext context) => Login(),
    Registration.routeName: (BuildContext context) => Registration(),
    Fault.routeName: (BuildContext context) => Fault(),
  };
}
