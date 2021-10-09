import 'package:firebase_auth/firebase_auth.dart';
import 'package:trapp_flutter/models/user_fb.dart';
import 'package:trapp_flutter/services/user_service.dart';

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
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register email & password
  Future registerWithEmailAndPassword(String email, String password, String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      // create a new document for the user with the uid
      await UserService(uid: user!.uid).updateUserData(name);
      return _userFromFbUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

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
