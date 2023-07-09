import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'signout_events.dart';
import 'signout_states.dart';

import '../../services/auth.dart';

class SignOutBloc extends Bloc<SignOutEvents, SignOutStates> {
  final AuthenticationService _authenticationService;
  SignOutBloc(this._authenticationService) : super(SignOutInitial());

  @override
  Stream<SignOutStates> mapEventToState(SignOutEvents event) async* {
    if (event is SignOutRequest) {
      yield SignOutLoading();
      try {
        await _authenticationService.signOut();
        yield SignOutSuccess();
      } on FirebaseAuthException catch (e) {
        yield SignOutFailed(message: e.message);
      } catch (e) {
        yield SignOutFailed(message: e.toString());
      }
    }
  }
}
