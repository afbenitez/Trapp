import 'package:firebase_auth/firebase_auth.dart';
import 'package:trapp_flutter/models/user_fb.dart';

class AuthService {
  //Private property for access all the different methods of authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create  user obj based on User for ease handling
  User_fb? _userFromFbUser(User? user) {
    return (user != null) ? User_fb(uid: user.uid) : null;
  }

  //Auth change user stream, it actively seeks for user changes
  Stream<User_fb?> get user {
    return _auth.authStateChanges().map(_userFromFbUser);
  }

  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFbUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in email & password

  //register email & password

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
