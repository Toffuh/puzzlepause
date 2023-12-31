import 'package:flutter/cupertino.dart';
import 'package:sign_in_button/sign_in_button.dart';

class Login extends StatelessWidget {
  const Login({super.key});

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
    );;
  }
}
