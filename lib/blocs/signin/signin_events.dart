import 'package:meta/meta.dart';

abstract class SignInEvents {
  const SignInEvents();
}

class SignInRequest extends SignInEvents {
  final String email;
  final String password;

  const SignInRequest({@required this.email, @required this.password});
}

class SignOutRequest extends SignInEvents {}
