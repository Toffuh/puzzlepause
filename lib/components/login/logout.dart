import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../globals/userData.dart';

class Logout extends StatelessWidget {
  final Function update;

  const Logout(this.update, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
        child: TextButton(
          child: const Text("Abmelden"),
          onPressed: () {
            signOutWithGoogle();
          },
        ),
      ),
    );
  }

  signOutWithGoogle() async {
    await GoogleSignIn(
            clientId:
                "152856632849-6rmn1klasong8617aoigrs1pguvqe04q.apps.googleusercontent.com")
        .signOut();
    FirebaseAuth.instance.signOut();

    UserData.getInstance().clearSharedPreferences();

    update();
  }
}
