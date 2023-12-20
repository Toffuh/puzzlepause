import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

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
                        onPressed: () => {},
                        child: const Icon(Icons.arrow_back)),
                    const Center(
                      child: Text("PuzzlePause - Anmelden",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30)),
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
                  onPressed: () => {},
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
}
