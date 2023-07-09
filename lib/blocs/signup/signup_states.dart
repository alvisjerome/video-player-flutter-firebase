import 'package:meta/meta.dart';

import '../../models/user.dart';

abstract class SignUpStates {
  const SignUpStates();
}

class SignUpInitial extends SignUpStates {}

class SignUpLoading extends SignUpStates {}

class SignUpSuccess extends SignUpStates {
  final AppUser appUser;

  const SignUpSuccess({@required this.appUser});
}

class SignUpFailed extends SignUpStates {
  final String message;

  const SignUpFailed({@required this.message});
}
