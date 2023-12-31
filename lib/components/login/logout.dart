import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Logout extends StatelessWidget {
  const Logout({super.key});

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
    );;
  }
}
