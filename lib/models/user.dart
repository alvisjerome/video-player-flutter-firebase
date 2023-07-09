import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

class AppUser {
  final String id;
  final String email;

  const AppUser({@required this.id, @required this.email});

  factory AppUser.fromCredentials(User user) {
    return AppUser(id: user.uid, email: user.email);
  }
}
