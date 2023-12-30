import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../globals/globals.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 16, 42),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 31, 16, 42),
        leading: IconButton(
          onPressed: () => {
            Navigator.pop(context)
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Center(
          child: Text(
            "Anmelden",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: Container(
              height: 40,
              width: 40,
              alignment: Alignment.topRight,
              child: Image.network(
                photoURL!,
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
      body: uid!.isEmpty ? logInWidget() : logOutWidget(),
    );
  }

  Widget logInWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 50, 0,0),
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

  Widget logOutWidget() {
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

    setState(() {
      uid = userCredential.user?.uid;
      email = userCredential.user?.email;
      displayName = userCredential.user?.displayName;
      photoURL = userCredential.user?.photoURL;
    });
  }

  signOutWithGoogle() async {
    await GoogleSignIn(clientId: "152856632849-6rmn1klasong8617aoigrs1pguvqe04q.apps.googleusercontent.com").signOut();
    FirebaseAuth.instance.signOut();

    setState(() {
      uid = "";
      email = "";
      displayName = "";
      photoURL = "https://cdn3.iconfinder.com/data/icons/social-messaging-productivity-6/128/profile-circle2-512.png";
    });
  }
}
