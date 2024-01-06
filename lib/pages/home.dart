import 'package:flutter/material.dart';
import 'package:puzzelpause/globals/userData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final SharedPreferences sharedPreferences;
  bool loading = true;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    sharedPreferences = await SharedPreferences.getInstance();

    String? uid = sharedPreferences.getString("uid");
    UserData.getInstance().uid = uid;

    String? email = sharedPreferences.getString("email");
    UserData.getInstance().email = email;

    String? displayName = sharedPreferences.getString("displayName");
    UserData.getInstance().displayName = displayName;

    String? photoURL = sharedPreferences.getString("photoURL");
    UserData.getInstance().photoURL = photoURL;

    int? points = sharedPreferences.getInt("points");
    UserData.getInstance().setPoints(points ?? 0);

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 16, 42),
      body: !loading
          ? Center(
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
                        onPressed: () =>
                            {Navigator.pushNamed(context, "/game")},
                        child: const Text("Spielen",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22))),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                    child: TextButton(
                        onPressed: () =>
                            {Navigator.pushNamed(context, "/login")},
                        child: const Text("Anmelden",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22))),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                    child: TextButton(
                        onPressed: () =>
                            {Navigator.pushNamed(context, "/leaderboard")},
                        child: const Text("Bestenliste",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22))),
                  ),
                ],
              ),
            )
          : const Text("loading"),
    );
  }
}
