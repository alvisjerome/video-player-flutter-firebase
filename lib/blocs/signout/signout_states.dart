import 'package:meta/meta.dart';

abstract class SignOutStates {
  const SignOutStates();
}

class SignOutInitial extends SignOutStates {}

class SignOutLoading extends SignOutStates {}

class SignOutSuccess extends SignOutStates {}

class SignOutFailed extends SignOutStates {
  final String message;

  const SignOutFailed({@required this.message});
}
