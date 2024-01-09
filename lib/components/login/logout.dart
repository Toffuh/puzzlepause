import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:puzzelpause/util/loginType.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../../globals/userData.dart';

class Logout extends StatelessWidget {
  final Function update;

  const Logout(this.update, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Center(
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
              child: const Text(
                "Falls Sie sich mit einem anderen Account anmelden möchten, können Sie sich hier abmelden.",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
            child: SignInButton(
              UserData.getInstance().loginType == LoginType.google
                  ? Buttons.google
                  : Buttons.gitHub,
              text: "Abmelden",
              onPressed: () {
                UserData.getInstance().loginType == LoginType.google
                    ? signOutWithGoogle()
                    : signOutWithGitHub();
              },
            ),
          ),
        ],
      ),
    );
  }

  signOutWithGoogle() async {
    await GoogleSignIn(
            clientId:
                "152856632849-6rmn1klasong8617aoigrs1pguvqe04q.apps.googleusercontent.com")
        .signOut();
    FirebaseAuth.instance.signOut();

    UserData.getInstance().clear();

    update();
  }

  signOutWithGitHub() async {
    FirebaseAuth.instance.signOut();

    UserData.getInstance().clear();

    update();
  }
}
