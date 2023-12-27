import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Leaderboard extends StatelessWidget {
  const Leaderboard({super.key});

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
                        child: const Icon(Icons.arrow_back)),
                    const Center(
                      child: Text("PuzzlePause - Bestenliste",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30)),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
