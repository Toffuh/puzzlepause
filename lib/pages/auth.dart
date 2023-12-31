import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:puzzelpause/components/login/login.dart';
import 'package:puzzelpause/components/login/logout.dart';
import 'package:puzzelpause/globals/userData.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 16, 42),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 31, 16, 42),
        leading: IconButton(
          onPressed: () => {Navigator.pop(context)},
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
                UserData.getInstance().photoURL,
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
      body: UserData.getInstance().uid == null ? const Login() : const Logout(),
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
      UserData.getInstance().uid = userCredential.user?.uid;
      UserData.getInstance().email = userCredential.user?.email;
      UserData.getInstance().displayName = userCredential.user?.displayName;
      UserData.getInstance().photoURL = userCredential.user?.photoURL ??
          "https://cdn3.iconfinder.com/data/icons/social-messaging-productivity-6/128/profile-circle2-512.png";
    });
  }

  signOutWithGoogle() async {
    await GoogleSignIn(
            clientId:
                "152856632849-6rmn1klasong8617aoigrs1pguvqe04q.apps.googleusercontent.com")
        .signOut();
    FirebaseAuth.instance.signOut();

    setState(() {
      UserData.getInstance().uid = null;
      UserData.getInstance().email = null;
      UserData.getInstance().displayName = null;
      UserData.getInstance().photoURL =
          "https://cdn3.iconfinder.com/data/icons/social-messaging-productivity-6/128/profile-circle2-512.png";
    });
  }
}
