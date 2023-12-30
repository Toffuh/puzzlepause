import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String? email = "";
  String? displayName = "";
  String? photoURL = "https://cdn3.iconfinder.com/data/icons/social-messaging-productivity-6/128/profile-circle2-512.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 16, 42),
      body: Center(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(30),
                child: Stack(
                  children: [
                    TextButton(
                        onPressed: () => {Navigator.pop(context)},
                        child:
                            const Icon(Icons.arrow_back, color: Colors.white)),
                    const Center(
                      child: Text("PuzzlePause - Anmelden",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30)),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      height: 60,
                      child: Image.network(photoURL!),
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: TextButton(
                  onPressed: () => {},
                  child: const Text("GitHub - OAuth",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22))),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: TextButton(
                  onPressed: () => {
                    signInWithGoogle()
                  },
                  child: const Text("Google - Auth",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22))),
            )
          ],
        ),
      ),
    );
  }

  signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn(clientId: "152856632849-6rmn1klasong8617aoigrs1pguvqe04q.apps.googleusercontent.com").signIn();

    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken
    );

    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(authCredential);

    setState(() {
      email = userCredential.user?.email;
      displayName = userCredential.user?.displayName;
      photoURL = userCredential.user?.photoURL;
    });
  }

  signOutWithGoogle() async {
    await GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut();

    setState(() {
      email = "";
      displayName = "";
      photoURL = "";
    });
  }
}
