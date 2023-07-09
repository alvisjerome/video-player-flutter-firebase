import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'signup_events.dart';
import 'signup_states.dart';

import '../../services/auth.dart';

class SignUpBloc extends Bloc<SignUpEvents, SignUpStates> {
  final AuthenticationService _authenticationService;
  SignUpBloc(this._authenticationService) : super(SignUpInitial());

  @override
  Stream<SignUpStates> mapEventToState(SignUpEvents event) async* {
    if (event is SignUpRequest) {
      yield SignUpLoading();
      try {
        final result = await _authenticationService.signUp(
            email: event.email, password: event.password);

        yield SignUpSuccess(appUser: result);
      } on FirebaseAuthException catch (e) {
        yield SignUpFailed(message: e.message);
      } catch (e) {
        yield SignUpFailed(message: e.toString());
      }
    }
  }
}
