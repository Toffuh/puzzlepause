import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleAuth {
  signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn(clientId: "152856632849-6rmn1klasong8617aoigrs1pguvqe04q.apps.googleusercontent.com").signIn();

    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken
    );

    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(authCredential);

    print(userCredential.user?.email);
    print(userCredential.user?.displayName);
    print(userCredential.user?.phoneNumber);
    print(userCredential.user?.photoURL);
  }

  signOutWithGoogle() async {
    await GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut();
  }
}