import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userfromFirebaseUser(FirebaseUser user) {
    return (user != null ? User(uid: user.uid) : null);
  }

  //auth change user stream

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userfromFirebaseUser);
  }

  // sign in anonymously

  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userfromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in using e-mail

  Future signInUsingEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userfromFirebaseUser(user);
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }

  // register a new account

  Future registerUsingEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

// creating a new document for the new user
      await DatabaseService(uid: user.uid)
          .updateUserData('0', 'new member', 100);

      return _userfromFirebaseUser(user);
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }

  // sign out of existing account

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
