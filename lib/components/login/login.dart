import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../../globals/userData.dart';

class Login extends StatelessWidget {
  final Function update;

  const Login(this.update, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: SignInButton(
                Buttons.gitHub,
                text: "Anmelden mit GitHub",
                onPressed: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: SignInButton(
                Buttons.google,
                text: "Anmelden mit Google",
                onPressed: () {
                  signInWithGoogle();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn(
            clientId:
                "152856632849-6rmn1klasong8617aoigrs1pguvqe04q.apps.googleusercontent.com")
        .signIn();

    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(authCredential);

    UserData.getInstance().uid = userCredential.user?.uid;
    UserData.getInstance().email = userCredential.user?.email;
    UserData.getInstance().displayName = userCredential.user?.displayName;
    UserData.getInstance().photoURL = userCredential.user?.photoURL ??
        "https://cdn3.iconfinder.com/data/icons/social-messaging-productivity-6/128/profile-circle2-512.png";

    update();
  }
}
