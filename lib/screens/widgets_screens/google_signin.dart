import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleSingInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;
      print(("${_user?.photoUrl.toString()}"));
      final googleAuth = await googleUser.authentication;

      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credentials);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
    Future googleLoggedOut() async {
      FirebaseAuth.instance.signOut();
      await googleSignIn.disconnect();
      FirebaseAuth.instance.signOut();
    }
}