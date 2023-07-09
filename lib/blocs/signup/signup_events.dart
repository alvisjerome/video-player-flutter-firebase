import 'package:meta/meta.dart';

abstract class SignUpEvents {
  const SignUpEvents();
}

class SignUpRequest extends SignUpEvents {
  final String email;
  final String password;

  const SignUpRequest({@required this.email, @required this.password});
}
