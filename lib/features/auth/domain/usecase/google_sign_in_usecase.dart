import 'dart:async';

import 'package:akurasipupuk/core/constants/string_const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInUsecase {
  static final _logger = Logger();

  static final _firebaseAuth = FirebaseAuth.instance;
  static final _googleSignIn = GoogleSignIn.instance;

  // static const List<String> _scopes = <String>[
  //   'https://www.googleapis.com/auth/contacts.readonly',
  // ];

  static Future<User?> signInWithGoogle() async {
    try {
      await _googleSignIn.initialize(
        serverClientId: StringConst.serverClientId,
      );

      final completer = Completer<User?>();

      // Dengarkan event autentikasi
      final sub = _googleSignIn.authenticationEvents.listen(
        (event) async {
          final user = await _handleAuthenticationEvent(event);
          completer.complete(user);
        },
        onError: (err) {
          completer.complete(null);
        },
      );

      _googleSignIn.attemptLightweightAuthentication();

      final result = await completer.future;

      await sub.cancel();
      return result;
    } catch (e) {
      return null;
    }
  }

  static Future<User?> _handleAuthenticationEvent(
      GoogleSignInAuthenticationEvent event) async {
    final GoogleSignInAccount? user = switch (event) {
      GoogleSignInAuthenticationEventSignIn() => event.user,
      GoogleSignInAuthenticationEventSignOut() => null
    };

    // final GoogleSignInClientAuthorization? authorization = await user?.authorizationClient.authorizationForScopes(_scopes);

    if (user == null) return null;

    final GoogleSignInAuthentication googleSignInAuthentication =
        user.authentication;

    final AuthCredential authCredential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      // accessToken: authorization!.accessToken
    );

    final currentUser =
        await _firebaseAuth.signInWithCredential(authCredential);

    _logger.i(currentUser.user!.uid);
    _logger.i(currentUser.user!.displayName);

    return currentUser.user;
  }

}
