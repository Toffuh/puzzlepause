import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:firebase_database/firebase_database.dart';

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
                onPressed: () {
                  signInWithGitHub(context);
                },
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
    //google sign in
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
    UserData.getInstance().photoURL = userCredential.user!.photoURL!;

    //add to firebase db
    await addToFirebaseDB(userCredential);

    //build main loginpage new
    update();
  }

  signInWithGitHub(BuildContext context) async {
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
        clientId: "a05c47ed7ace610ddcf7",
        clientSecret: "5b6ab5c4af723b0ef4d9642177cb789702e2ed02",
        redirectUrl:
            "https://puzzlepause-fe548.firebaseapp.com/__/auth/handler");

    final result = await gitHubSignIn.signIn(context);

    AuthCredential authCredential =
        GithubAuthProvider.credential(result.token!);

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(authCredential);

    UserData.getInstance().uid = userCredential.user?.uid;
    UserData.getInstance().email = userCredential.user?.email;
    UserData.getInstance().displayName = userCredential.user?.displayName;
    UserData.getInstance().photoURL = userCredential.user!.photoURL!;

    //add to firebase db
    await addToFirebaseDB(userCredential);

    //build main loginpage new
    update();
  }

  addToFirebaseDB(UserCredential userCredential) async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    final snapshot = await databaseReference
        .child("users/${UserData.getInstance().uid}")
        .get();

    if (snapshot.exists) {
      int currentHighScore = UserData.getInstance().points;
      int remoteHighScore =
          int.parse(snapshot.child("points").value.toString());

      if (remoteHighScore > currentHighScore) {
        UserData.getInstance().setPoints(remoteHighScore);
      } else {
        await databaseReference
            .child("users/${UserData.getInstance().uid}")
            .update({"points": currentHighScore});
      }
    } else {
      await databaseReference.child("users/${UserData.getInstance().uid}").set({
        "email": UserData.getInstance().email,
        "displayName": UserData.getInstance().displayName,
        "points": UserData.getInstance().points
      });
    }
  }
}
