import 'package:akurasipupuk/features/auth/presentation/page/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> signOutFromGoogle(BuildContext context) async {
  FirebaseAuth.instance.signOut().then(
    (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Berhasil keluar!")),
      );

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LoginPage(),
      ));
    },
  );
}
