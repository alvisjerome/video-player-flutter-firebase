import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../models/user.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<AppUser> signIn(
      {@required String email, @required String password}) async {
    final UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    return AppUser.fromCredentials(userCredential.user);
  }

  Future<AppUser> signUp({
    @required String email,
    @required String password,
  }) async {
    final UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    return AppUser.fromCredentials(userCredential.user);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
