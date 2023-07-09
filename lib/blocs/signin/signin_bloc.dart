import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'signin_events.dart';
import 'signin_states.dart';

import '../../services/auth.dart';

class SignInBloc extends Bloc<SignInEvents, SignInStates> {
  final AuthenticationService _authenticationService;

  SignInBloc(this._authenticationService) : super(SignInInitial());
  @override
  Stream<SignInStates> mapEventToState(SignInEvents event) async* {
    if (event is SignInRequest) {
      yield SignInLoading();
      try {
        final result = await _authenticationService.signIn(
            email: event.email, password: event.password);

        yield SignInSuccess(appUser: result);
      } on FirebaseAuthException catch (e) {
        yield SignInFailed(message: e.message);
      } catch (e) {
        yield SignInFailed(message: e.toString());
      }
    }
  }
}
