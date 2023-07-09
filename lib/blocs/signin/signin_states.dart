import 'package:meta/meta.dart';
import '../../models/user.dart';

abstract class SignInStates {
  const SignInStates();
}

class SignInInitial extends SignInStates {}

class SignInLoading extends SignInStates {}

class SignInSuccess extends SignInStates {
  final AppUser appUser;
  const SignInSuccess({@required this.appUser});
}

class SignInFailed extends SignInStates {
  final String message;

  const SignInFailed({@required this.message});
}
