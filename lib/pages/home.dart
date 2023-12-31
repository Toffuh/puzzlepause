import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 16, 42),
      body: Center(
        child: Column(
          children: [
            const Padding(
                padding: EdgeInsets.all(30),
                child: Stack(
                  children: [
                    Center(
                      child: Text("PuzzlePause - Gemütliches Tetris",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30)),
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: TextButton(
                  onPressed: () => {
                    Navigator.pushNamed(context, "/game")
                  },
                  child: const Text("Spielen",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22))),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: TextButton(
                  onPressed: () => {
                    Navigator.pushNamed(context, "/login")
                  },
                  child: const Text("Anmelden",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22))),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: TextButton(
                  onPressed: () => {
                    Navigator.pushNamed(context, "/leaderboard")
                  },
                  child: const Text("Bestenliste",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22))),
            ),
          ],
        ),
      ),
    );
  }
}
