import 'package:fdm_expenses_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object from firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid, email: user.email, currentIndex: 0) : null;
  }

  //auth change user stream
  Stream<User> get user {
    //returns user object if signed in, or null if user is signed out
    return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser); //converts to user object
  }

  //sign in anonymously
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return e.toString();
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

//<<<<<<< HEAD
//  //send password reset email
//  Future sendPasswordResetEmail(String email) async {
//    return _auth.sendPasswordResetEmail(email: email);

  //reset password with email
  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
  
  //change password 
  Future changePassword(String password) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    try {
      print("OAKSDNFGAOPSKIFNAOKSFNAOLSKFN");
      await user.updatePassword(password);
      return true;
    } catch(error) {
      return error.toString();
    }

  }


}